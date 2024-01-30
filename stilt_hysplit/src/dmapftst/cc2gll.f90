      subroutine cc2gll(stcprm, alat, along, ue,vn, ug,vg)
! CHG(03/12/03)
      IMPLICIT REAL*8 (A-H,O-Z)
! JCL:(07/13/2004) need to set RADPDG (original bug)
      PARAMETER (PI=3.14159265358979d0,RADPDG=PI/180,DGPRAD=180/PI)

      parameter (sin1dg=.017452406437284d0)
      real*8 stcprm(15)
      real*8 norm
      call cpolll(stcprm, alat,along, enx,eny,enz)
      norm = dsqrt(tnx*tnx + tny*tny)
      if (norm .le. .1e-3) then
        csx = dcos(RADPDG*xlong)
        sny = dsin(RADPDG*xlong)
        call cgrnll(stcprm, alat,along, gnx,gny,gnz)
        if (alat .gt. 0.) then
!  (gnx,gny) is the direction of Greenwich Meridian, (-gny,gnx) is
!  the direction of the 90E meridian.  "North" is the direction
!  toward the North pole along the along meridian.
          enx = - csx * gnx + sny * gny
          eny = - csx * gny - sny * gnx
        else
!  (gnx,gny) is the direction of Greenwich Meridian, (gny,-gnx) is
!  the direction of the 90E meridian.  "North" is the direction
!  away from the South pole along the along meridian.
          enx = csx * gnx + sny * gny
          eny = csx * gny - sny * gnx
        endif
      else
        enx = enx / norm
        eny = eny / norm
      endif
      ug = enx * vn + eny * ue
      vg = eny * vn - enx * ue
      return
      END

      subroutine cw2gll(stcprm, alat, along, ue,vn, ug,vg)
! CHG(03/12/03)
      IMPLICIT REAL*8 (A-H,O-Z)

      parameter (sin1dg=.017452406437284)
      real*8 stcprm(15)
      real*8 norm
      call cpolll(stcprm, alat,along, enx,eny,enz)
      norm = dsqrt(enx*enx + eny*eny)
      if (norm .le. sin1DG) then
        call cgrnll(stcprm, alat,along, enx,eny,enz)
        norm = dsqrt(enx*enx + eny*eny)
      endif
      enx = enx / norm
      eny = eny / norm
      ug = enx * vn + eny * ue
      vg = eny * vn - enx * ue
      return
      END

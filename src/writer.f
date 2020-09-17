***********************************************************************
       SUBROUTINE WRITE_DIVROT(FILERR5,NX,NY,NZ,ITER,T,ZETA,NL,NPATCH,
     &            PATCHNX,PATCHNY,PATCHNZ)
***********************************************************************
      IMPLICIT NONE

      INCLUDE 'vortex_parameters.dat'

*     FUNCTION ARGUMENTS
      CHARACTER*30 FILERR5
      INTEGER NX, NY, NZ, NL, ITER
      REAL*4 T, ZETA
      INTEGER NPATCH(0:NLEVELS)
      INTEGER PATCHNX(NPALEV),PATCHNY(NPALEV),PATCHNZ(NPALEV)

*     INPUTS FROM COMMON MODULES
      REAL*4 ROTAX_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAY_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAZ_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAX_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 ROTAY_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 ROTAZ_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      COMMON /ROTS/ ROTAX_0,ROTAY_0,ROTAZ_0,ROTAX_1,ROTAY_1,ROTAZ_1

      REAL*4 DIVER0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 DIVER(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      COMMON /DIVERGENCE/ DIVER0, DIVER

*     VARIABLES
      INTEGER IR, I, LOW1, LOW2, IX, J, K, N1, N2, N3
      REAL*4, ALLOCATABLE::SCR4(:,:,:)

*     OPEN THE OUTPUT FILE
      OPEN(25,FILE=FILERR5,STATUS='UNKNOWN',FORM='UNFORMATTED',
     &     POSITION='APPEND')

*     WRITE GENERAL DATA
      WRITE(25) ITER, T, ZETA, NL

*     WRITE THE DIVERGENCE FIELD
      WRITE(25) (((DIVER0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)

      ALLOCATE(SCR4(NAMRX,NAMRY,NAMRZ))

      DO IR=1,NL

        LOW1=SUM(NPATCH(0:IR-1))+1
        LOW2=SUM(NPATCH(0:IR))
        DO I=LOW1,LOW2

          N1=PATCHNX(I)
          N2=PATCHNY(I)
          N3=PATCHNZ(I)

          SCR4(1:N1,1:N2,1:N3)=DIVER(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

        END DO
      END DO

*     WRITE THE ROTATIONAL FIELDS (x, y, z)
      WRITE(25) (((ROTAX_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((ROTAY_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((ROTAZ_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)

      DO IR=1,NL

        LOW1=SUM(NPATCH(0:IR-1))+1
        LOW2=SUM(NPATCH(0:IR))
        DO I=LOW1,LOW2

          N1=PATCHNX(I)
          N2=PATCHNY(I)
          N3=PATCHNZ(I)

          SCR4(1:N1,1:N2,1:N3)=ROTAX_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=ROTAY_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=ROTAZ_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

        END DO
      END DO


      DEALLOCATE(SCR4)

      CLOSE(25)

      END


***********************************************************************
       SUBROUTINE WRITE_POTENTIALS(FILERR5,NX,NY,NZ,ITER,T,ZETA,NL,
     &            NPATCH,PATCHNX,PATCHNY,PATCHNZ)
***********************************************************************
      IMPLICIT NONE

      INCLUDE 'vortex_parameters.dat'

*     FUNCTION ARGUMENTS
      CHARACTER*30 FILERR5
      INTEGER NX, NY, NZ, NL, ITER
      REAL*4 T, ZETA
      INTEGER NPATCH(0:NLEVELS)
      INTEGER PATCHNX(NPALEV),PATCHNY(NPALEV),PATCHNZ(NPALEV)

*     INPUTS FROM COMMON MODULES
      REAL*4 ROTAX_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAY_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAZ_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAX_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 ROTAY_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 ROTAZ_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      COMMON /ROTS/ ROTAX_0,ROTAY_0,ROTAZ_0,ROTAX_1,ROTAY_1,ROTAZ_1

      REAL*4 DIVER0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 DIVER(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      COMMON /DIVERGENCE/ DIVER0, DIVER

*     VARIABLES
      INTEGER IR, I, LOW1, LOW2, IX, J, K, N1, N2, N3
      REAL*4, ALLOCATABLE::SCR4(:,:,:)

*     OPEN THE OUTPUT FILE
      OPEN(25,FILE=FILERR5,STATUS='UNKNOWN',FORM='UNFORMATTED',
     &     POSITION='APPEND')

*     WRITE THE SCALAR POTENTIAL
      WRITE(25) (((DIVER0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)

      ALLOCATE(SCR4(NAMRX,NAMRY,NAMRZ))

      DO IR=1,NL

        LOW1=SUM(NPATCH(0:IR-1))+1
        LOW2=SUM(NPATCH(0:IR))
        DO I=LOW1,LOW2

          N1=PATCHNX(I)
          N2=PATCHNY(I)
          N3=PATCHNZ(I)

          SCR4(1:N1,1:N2,1:N3)=DIVER(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

        END DO
      END DO

*     WRITE THE VECTOR POTENTIAL (x, y, z)
      WRITE(25) (((ROTAX_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((ROTAY_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((ROTAZ_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)

      DO IR=1,NL

        LOW1=SUM(NPATCH(0:IR-1))+1
        LOW2=SUM(NPATCH(0:IR))
        DO I=LOW1,LOW2

          N1=PATCHNX(I)
          N2=PATCHNY(I)
          N3=PATCHNZ(I)

          SCR4(1:N1,1:N2,1:N3)=ROTAX_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=ROTAY_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=ROTAZ_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

        END DO
      END DO


      DEALLOCATE(SCR4)

      CLOSE(25)

      END


***********************************************************************
       SUBROUTINE WRITE_TOTALVELOCITY(FILERR5,NX,NY,NZ,ITER,T,ZETA,NL,
     &                             NPATCH,PATCHNX,PATCHNY,PATCHNZ)
***********************************************************************
      IMPLICIT NONE

      INCLUDE 'vortex_parameters.dat'

*     FUNCTION ARGUMENTS
      CHARACTER*30 FILERR5
      INTEGER NX, NY, NZ, NL, ITER
      REAL*4 T, ZETA
      INTEGER NPATCH(0:NLEVELS)
      INTEGER PATCHNX(NPALEV),PATCHNY(NPALEV),PATCHNZ(NPALEV)

*     INPUTS FROM COMMON MODULES

      REAL*4 U2(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 U3(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 U4(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 U12(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 U13(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 U14(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      COMMON /VELOC/ U2,U3,U4,U12,U13,U14

*     VARIABLES
      INTEGER IR, I, LOW1, LOW2, IX, J, K, N1, N2, N3
      REAL*4, ALLOCATABLE::SCR4(:,:,:)

*     OPEN THE OUTPUT FILE
      OPEN(25,FILE=FILERR5,STATUS='UNKNOWN',FORM='UNFORMATTED',
     &     POSITION='APPEND')

*     WRITE THE TOTAL VELOCITY FIELD (x, y, z)
      WRITE(25) (((U2(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((U3(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((U4(I,J,K),I=1,NX),J=1,NY),K=1,NZ)

      ALLOCATE(SCR4(NAMRX,NAMRY,NAMRZ))

      DO IR=1,NL

        LOW1=SUM(NPATCH(0:IR-1))+1
        LOW2=SUM(NPATCH(0:IR))
        DO I=LOW1,LOW2

          N1=PATCHNX(I)
          N2=PATCHNY(I)
          N3=PATCHNZ(I)

          SCR4(1:N1,1:N2,1:N3)=U12(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=U13(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=U14(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

        END DO
      END DO

      DEALLOCATE(SCR4)

      CLOSE(25)

      END



***********************************************************************
       SUBROUTINE WRITE_VELOCITIES(FILERR5,NX,NY,NZ,ITER,T,ZETA,NL,
     &                             NPATCH,PATCHNX,PATCHNY,PATCHNZ)
***********************************************************************
      IMPLICIT NONE

      INCLUDE 'vortex_parameters.dat'

*     FUNCTION ARGUMENTS
      CHARACTER*30 FILERR5
      INTEGER NX, NY, NZ, NL, ITER
      REAL*4 T, ZETA
      INTEGER NPATCH(0:NLEVELS)
      INTEGER PATCHNX(NPALEV),PATCHNY(NPALEV),PATCHNZ(NPALEV)

*     INPUTS FROM COMMON MODULES
*     ROTA has been recycled as the rotational velocity
      REAL*4 ROTAX_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAY_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAZ_0(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 ROTAX_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 ROTAY_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 ROTAZ_1(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      COMMON /ROTS/ ROTAX_0,ROTAY_0,ROTAZ_0,ROTAX_1,ROTAY_1,ROTAZ_1

      REAL*4 U2P(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 U3P(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 U4P(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
      REAL*4 U12P(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 U13P(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      REAL*4 U14P(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
      COMMON /VELOC_P/ U2P,U3P,U4P,U12P,U13P,U14P

*      original, total velocity
       REAL*4 U2(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
       REAL*4 U3(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
       REAL*4 U4(0:NMAX+1,0:NMAY+1,0:NMAZ+1)
       REAL*4 U12(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
       REAL*4 U13(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
       REAL*4 U14(0:NAMRX+1,0:NAMRY+1,0:NAMRZ+1,NPALEV)
       COMMON /VELOC_ORIGINAL/ U2,U3,U4,U12,U13,U14

*     VARIABLES
      INTEGER IR, I, LOW1, LOW2, IX, J, K, N1, N2, N3
      REAL*4, ALLOCATABLE::SCR4(:,:,:)

*     OPEN THE OUTPUT FILE
      OPEN(25,FILE=FILERR5,STATUS='UNKNOWN',FORM='UNFORMATTED',
     &     POSITION='APPEND')

*     WRITE THE TOTAL VELOCITY
      WRITE(25) (((U2(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((U3(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((U4(I,J,K),I=1,NX),J=1,NY),K=1,NZ)

      ALLOCATE(SCR4(NAMRX,NAMRY,NAMRZ))

      DO IR=1,NL

       LOW1=SUM(NPATCH(0:IR-1))+1
       LOW2=SUM(NPATCH(0:IR))
       DO I=LOW1,LOW2

         N1=PATCHNX(I)
         N2=PATCHNY(I)
         N3=PATCHNZ(I)

         SCR4(1:N1,1:N2,1:N3)=U12(1:N1,1:N2,1:N3,I)
         WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
         SCR4(1:N1,1:N2,1:N3)=U13(1:N1,1:N2,1:N3,I)
         WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
         SCR4(1:N1,1:N2,1:N3)=U14(1:N1,1:N2,1:N3,I)
         WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

       END DO
      END DO


*     WRITE THE COMPRESSIONAL VELOCITY
      WRITE(25) (((U2P(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((U3P(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((U4P(I,J,K),I=1,NX),J=1,NY),K=1,NZ)

      DO IR=1,NL

        LOW1=SUM(NPATCH(0:IR-1))+1
        LOW2=SUM(NPATCH(0:IR))
        DO I=LOW1,LOW2

          N1=PATCHNX(I)
          N2=PATCHNY(I)
          N3=PATCHNZ(I)

          SCR4(1:N1,1:N2,1:N3)=U12P(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=U13P(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=U14P(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

        END DO
      END DO

*     WRITE THE ROTATIONAL VELOCITY
      WRITE(25) (((ROTAX_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((ROTAY_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)
      WRITE(25) (((ROTAZ_0(I,J,K),I=1,NX),J=1,NY),K=1,NZ)

      DO IR=1,NL

        LOW1=SUM(NPATCH(0:IR-1))+1
        LOW2=SUM(NPATCH(0:IR))
        DO I=LOW1,LOW2

          N1=PATCHNX(I)
          N2=PATCHNY(I)
          N3=PATCHNZ(I)

          SCR4(1:N1,1:N2,1:N3)=ROTAX_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=ROTAY_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)
          SCR4(1:N1,1:N2,1:N3)=ROTAZ_1(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

        END DO
      END DO

      DEALLOCATE(SCR4)

      CLOSE(25)

      END


***********************************************************************
       SUBROUTINE WRITE_SOLAPST(FILERR5,NX,NY,NZ,ITER,T,ZETA,NL,NPATCH,
     &                          PATCHNX,PATCHNY,PATCHNZ,SOLAPST)
***********************************************************************
      IMPLICIT NONE

      INCLUDE 'vortex_parameters.dat'

*     FUNCTION ARGUMENTS
      CHARACTER*30 FILERR5
      INTEGER NX, NY, NZ, NL, ITER
      REAL*4 T, ZETA
      INTEGER NPATCH(0:NLEVELS)
      INTEGER PATCHNX(NPALEV),PATCHNY(NPALEV),PATCHNZ(NPALEV)
      INTEGER SOLAPST(NAMRX,NAMRY,NAMRZ,NPALEV)

*     VARIABLES
      INTEGER IR, I, LOW1, LOW2, IX, J, K, N1, N2, N3
      INTEGER, ALLOCATABLE::SCR4(:,:,:)

*     OPEN THE OUTPUT FILE
      OPEN(25,FILE=FILERR5,STATUS='UNKNOWN',FORM='UNFORMATTED',
     &     POSITION='APPEND')

      ALLOCATE(SCR4(NAMRX,NAMRY,NAMRZ))

      DO IR=1,NL

        LOW1=SUM(NPATCH(0:IR-1))+1
        LOW2=SUM(NPATCH(0:IR))
        DO I=LOW1,LOW2

          N1=PATCHNX(I)
          N2=PATCHNY(I)
          N3=PATCHNZ(I)

          SCR4(1:N1,1:N2,1:N3)=SOLAPST(1:N1,1:N2,1:N3,I)
          WRITE(25) (((SCR4(IX,J,K),IX=1,N1),J=1,N2),K=1,N3)

        END DO
      END DO

      DEALLOCATE(SCR4)

      CLOSE(25)

      END

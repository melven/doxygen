!// objective: test type bound procedures
!// check: structmymodule_1_1t1.xml
!// config: OPTIMIZE_FOR_FORTRAN=YES

module myModule
  implicit none
  private

  public :: T1

  type T1
    integer :: publicVariable
  contains
    procedure :: firstProc
    procedure, non_overridable :: secondProc => secondProc_impl
    procedure, nopass :: staticProc
    procedure, pass(this) :: redundantPass => firstProc
    generic :: overloadedProc => firstProc, secondProc
    final :: destructor
  end type T1

contains

  subroutine firstProc(this, i)
    class(T1) :: this
    integer, intent(in) :: i
  end subroutine

  subroutine secondProc_impl(this, r)
    class(T1) :: this
    real, intent(out) :: r
  end subroutine

  subroutine staticProc(someArg)
    integer :: someArg
  end subroutine

  elemental subroutine destructor(this)
    type(T1), intent(inout) :: this
  end subroutine

end module myModule

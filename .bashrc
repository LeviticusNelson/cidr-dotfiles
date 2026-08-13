case $- in
  *i*) ;;
  *) return ;;
esac

command -v fish >/dev/null 2>&1 && exec fish -l

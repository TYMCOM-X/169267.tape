	dimension work(4096)
	common work
	integer proj(5),polit,grids,gridx,blankx
	real MINLON,MAXLON,MINLAT,MAXLAT
	call bgnpl(-1)
	call tek(30,0)
	call nobrdr
	call page(14.5,11.0)
	blankx=' '
	grids=' '
	gridx=1
	write(5,10)
10	format(' PROJECTION: ',$)
	read(5,11)proj
11	format(5a5)

	write(5,12)
12	format('+MIN LATITUDE: ',$)
	read(5,13)MINLAT
13	format(F)
	write(5,14)
14	format('+MAX LATITUDE: ',$)
	read(5,13)MAXLAT
	write(5,15)
15	format('+MIN LONGITUDE: ',$)
	read(5,13)MINLON
	write(5,16)
16	format('+MAX LONGITUDE: ',$)
	read(5,13)MAXLON

	write(5,17)
17	format('+INCLUDE POLITICAL? ',$)
	read(5,18)polit
18	format(A1)

	write(5,19)
19	format('+GRID TYPE (<CR>,DOT,DASH,SOLID): ',$)
	read(5,20)GRIDS
20	format(a5)
	if (grids.eq.' ') goto 101
	write(5,21)
21	format('+GRID SPACING: ',$)
	read(5,22)GRIDX
22	format(I)
	write(5,23)
23	format('+BLANKING (<CR>,LAND,WATER): ',$)
	read(5,20)BLANKX
101	continue
	CALL MAPOLE(-90,45)
	call projct(proj)
	CALL title(0,0, 0,0, 0,0, 14.0,10.5)
	call mapgr(MINLON,10.0,MAXLON,MINLAT,10.0,MAXLAT)
C	call mapfil('HERSHEY')
	if (polit.eq.'Y') call mapfil('POLITICAL')
	if (blankx.ne.' ') call lblank(blankx,4096)
	if (grids.eq.'DOT') call dot
	if (grids.eq.'DASH') call dash
	if (grids.ne.' ') call grid(gridx,gridx)
	call endpl(0)
	call donepl
	end
  
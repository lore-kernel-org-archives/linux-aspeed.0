From: Liam Howlett <liam.howlett@oracle.com>
Date: Mon, 18 Jul 2022 13:55:22 +0000
Subject: [linux-next:master] BUILD REGRESSION
 4662b7adea50bb62e993a67f611f3be625d3df0d
In-Reply-To: <20220716180319.dcb09d8ce9519368695c1108@linux-foundation.org>
References: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com>
 <20220716180319.dcb09d8ce9519368695c1108@linux-foundation.org>
Message-ID: <20220718135515.vyuy6rozchf755hq@revolver>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

* Andrew Morton <akpm@linux-foundation.org> [220716 21:03]:
> On Thu, 14 Jul 2022 09:56:19 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > lib/maple_tree.c:1522:52: warning: Parameter 'gaps' can be declared with const [constParameter]
> > lib/maple_tree.c:1871:21: warning: Array index 'split' is used before limits check. [arrayIndexThenCheck]
> > lib/maple_tree.c:2033:55: warning: Parameter 'mas' can be declared with const [constParameter]
> > lib/maple_tree.c:2426:8: warning: Redundant initialization for 'r_tmp'. The initialized value is overwritten before it is read. [redundantInitialization]
> > lib/maple_tree.c:2427:8: warning: Redundant initialization for 'l_tmp'. The initialized value is overwritten before it is read. [redundantInitialization]
> > lib/maple_tree.c:3160:22: warning: Found suspicious operator ',' [constStatement]
> > lib/maple_tree.c:3208:11: warning: Size of pointer 'pivs' used instead of size of its data. [pointerSize]
> > lib/maple_tree.c:326:2: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
> > lib/maple_tree.c:4266:15: warning: The if condition is the same as the previous if condition [duplicateCondition]
> > lib/maple_tree.c:4302:23: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
> > lib/maple_tree.c:694:59: warning: Parameter 'pivots' can be declared with const [constParameter]
> > lib/test_printf.c:415:11: warning: Local variable 'addr' shadows outer function [shadowFunction]
> > mm/highmem.c:737:13: warning: Uninitialized variable: pam->page [uninitvar]
> > mm/migrate.c:355:53: warning: Parameter 'mapping' can be declared with const [constParameter]
> > mm/migrate.c:875:7: warning: Redundant initialization for 'rc'. The initialized value is overwritten before it is read. [redundantInitialization]
> > mm/mlock.c:230:20: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
> > mm/slab.c:1635:24: warning: Uninitialized variables: slab.__page_flags, slab.__unused_1, slab.freelist, slab.units, slab.__unused_2, slab.__page_refcount [uninitvar]
> > mm/slab.c:3289:7: warning: Redundant assignment of 'objp' to itself. [selfAssignment]
> > mm/slab.c:3509:8: warning: Redundant assignment of 'p[i]' to itself. [selfAssignment]
> > mm/slab.c:405:9: warning: Local variable 'slab_size' shadows outer function [shadowFunction]
> > mm/vmstat.c:1409:53: warning: Parameter 'pos' can be declared with const [constParameter]
> > mm/vmstat.c:1650:68: warning: Parameter 'zone' can be declared with const [constParameter]
> > mm/zsmalloc.c:2019:15: warning: Uninitialized variables: zspage.huge, zspage.fullness, zspage.class, zspage.isolated, zspage.magic, zspage.inuse, zspage.freeobj, zspage.first_page, zspage.lock [uninitvar]
> > mm/zsmalloc.c:2060:16: warning: Local variable 'obj_allocated' shadows outer function [shadowFunction]
> 
> urgh, thanks, lots of stuff to go through here.
> 
> Liam, I suggest we worry about the mapletree things at a later time ;)

I'm not sure where we stand with all that goings on here with an rc8 and
the concerns raised by Hugh, but I can produce a fix for these issues if
you'd like?

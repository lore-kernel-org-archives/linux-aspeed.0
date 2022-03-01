From: Kees Cook <keescook@chromium.org>
Date: Tue, 1 Mar 2022 10:21:24 -0800
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CEDAD0D9-56EE-4105-9107-72C2EAD940B0@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <FC710A1A-524E-481B-A668-FC258F529A2E@gmail.com>
 <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
 <CEDAD0D9-56EE-4105-9107-72C2EAD940B0@gmail.com>
Message-ID: <202203011016.48A181EE50@keescook>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 01, 2022 at 12:28:15PM +0100, Jakob Koschel wrote:
> Based on the coccinelle script there are ~480 cases that need fixing
> in total. I'll now finish all of them and then split them by
> submodules as Greg suggested and repost a patch set per submodule.
> Sounds good?

To help with this splitting, see:
https://github.com/kees/kernel-tools/blob/trunk/split-on-maintainer

It's not perfect, but it'll get you really close. For example, if you
had a single big tree-wide patch applied to your tree:

$ rm 0*.patch
$ git format-patch -1 HEAD
$ mv 0*.patch treewide.patch
$ split-on-maintainer treewide.patch
$ ls 0*.patch

If you have a build log before the patch that spits out warnings, the
--build-log argument can extract those warnings on a per-file basis, too
(though this can be fragile).

-- 
Kees Cook

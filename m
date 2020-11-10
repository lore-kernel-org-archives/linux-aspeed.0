From: Joe Perches <joe@perches.com>
Date: Mon, 09 Nov 2020 18:52:08 -0800
Subject: Subject: [RFC] clang tooling cleanups
In-Reply-To: <20201027164255.1573301-1-trix@redhat.com>
References: <20201027164255.1573301-1-trix@redhat.com>
Message-ID: <3c39c363690d0b46069afddc3ad09213011e5cd4.camel@perches.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-10-27 at 09:42 -0700, trix at redhat.com wrote:
> This rfc will describe
> An upcoming treewide cleanup.
> How clang tooling was used to programatically do the clean up.
> Solicit opinions on how to generally use clang tooling.
> 
> The clang warning -Wextra-semi-stmt produces about 10k warnings.
> Reviewing these, a subset of semicolon after a switch looks safe to
> fix all the time.  An example problem
> 
> void foo(int a) {
> ?????switch(a) {
> ?????	       case 1:
> 	       ...
> ?????}; <--- extra semicolon
> }
> 
> Treewide, there are about 100 problems in 50 files for x86_64 allyesconfig.
> These fixes will be the upcoming cleanup.

coccinelle already does some of these.

For instance: scripts/coccinelle/misc/semicolon.cocci

Perhaps some tool coordination can be done here as
coccinelle/checkpatch/clang/Lindent call all be used
to do some facet or another of these cleanup issues.




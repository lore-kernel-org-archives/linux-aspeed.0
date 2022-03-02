From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 Mar 2022 12:59:28 -0800
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=wikKPC0LUqZ8++EC5JOvGdBqVH9uUaTX=DvBioDoReYww@mail.gmail.com>
References: <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
 <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
 <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com>
 <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
 <0ced2b155b984882b39e895f0211037c@AcuMS.aculab.com>
 <CAHk-=wix0HLCBs5sxAeW3uckg0YncXbTjMsE-Tv8WzmkOgLAXQ@mail.gmail.com>
 <78ccb184-405e-da93-1e02-078f90d2b9bc@rasmusvillemoes.dk>
 <202203021158.DB5204A0@keescook>
 <CAHk-=wikKPC0LUqZ8++EC5JOvGdBqVH9uUaTX=DvBioDoReYww@mail.gmail.com>
Message-ID: <202203021256.69D7C4BCA6@keescook>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 02, 2022 at 12:18:45PM -0800, Linus Torvalds wrote:
> On Wed, Mar 2, 2022 at 12:07 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > I've long wanted to change kfree() to explicitly set pointers to NULL on
> > free. https://github.com/KSPP/linux/issues/87
> 
> We've had this discussion with the gcc people in the past, and gcc
> actually has some support for it, but it's sadly tied to the actual
> function name (ie gcc has some special-casing for "free()")
> 
> See
> 
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94527
> 
> for some of that discussion.
> 
> Oh, and I see some patch actually got merged since I looked there last
> so that you can mark "deallocator" functions, but I think it's only
> for the context matching, not for actually killing accesses to the
> pointer afterwards.

Ah! I missed that getting added in GCC 11. But yes, there it is:

https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-malloc-function-attribute

Hah, now we may need to split __malloc from __alloc_size. ;)

I'd still like the NULL assignment behavior, though, since some things
can easily avoid static analysis.

-- 
Kees Cook

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 3 Mar 2022 11:37:16 +0300
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <202203021158.DB5204A0@keescook>
References: <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
 <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
 <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com>
 <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
 <0ced2b155b984882b39e895f0211037c@AcuMS.aculab.com>
 <CAHk-=wix0HLCBs5sxAeW3uckg0YncXbTjMsE-Tv8WzmkOgLAXQ@mail.gmail.com>
 <78ccb184-405e-da93-1e02-078f90d2b9bc@rasmusvillemoes.dk>
 <202203021158.DB5204A0@keescook>
Message-ID: <20220303083716.GL2812@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 02, 2022 at 12:07:04PM -0800, Kees Cook wrote:
> On Wed, Mar 02, 2022 at 10:29:31AM +0100, Rasmus Villemoes wrote:
> > This won't help the current issue (because it doesn't exist and might
> > never), but just in case some compiler people are listening, I'd like to
> > have some sort of way to tell the compiler "treat this variable as
> > uninitialized from here on". So one could do
> > 
> > #define kfree(p) do { __kfree(p); __magic_uninit(p); } while (0)
> > 
> > with __magic_uninit being a magic no-op that doesn't affect the
> > semantics of the code, but could be used by the compiler's "[is/may be]
> > used uninitialized" machinery to flag e.g. double frees on some odd
> > error path etc. It would probably only work for local automatic
> > variables, but it should be possible to just ignore the hint if p is
> > some expression like foo->bar or has side effects. If we had that, the
> > end-of-loop test could include that to "uninitialize" the iterator.
> 
> I've long wanted to change kfree() to explicitly set pointers to NULL on
> free. https://github.com/KSPP/linux/issues/87 

You also need to be a bit careful with existing code because there are
places which do things like:

drivers/usb/host/r8a66597-hcd.c
   424          kfree(dev);
                      ^^^
   425  
   426          for (port = 0; port < r8a66597->max_root_hub; port++) {
   427                  if (r8a66597->root_hub[port].dev == dev) {
                                                            ^^^
   428                          r8a66597->root_hub[port].dev = NULL;
   429                          break;
   430                  }
   431          }

Printing the freed pointer in debug code is another thing people do.

regards,
dan carpenter


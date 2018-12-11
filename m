From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 10 Dec 2018 17:25:25 -0700
Subject: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
In-Reply-To: <CACPK8XfxQxMqLo10FSRPHdUVt4vr5K32xB2C_SXLAPEza--v0w@mail.gmail.com>
References: <20181211000506.7559-1-natechancellor@gmail.com>
 <1544487006.3301683.1605247720.567E9685@webmail.messagingengine.com>
 <CACPK8XfxQxMqLo10FSRPHdUVt4vr5K32xB2C_SXLAPEza--v0w@mail.gmail.com>
Message-ID: <20181211002525.GA8468@flashbox>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 11, 2018 at 10:46:26AM +1030, Joel Stanley wrote:
> On Tue, 11 Dec 2018 at 10:40, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Tue, 11 Dec 2018, at 10:35, Nathan Chancellor wrote:
> > > Clang does not support this option:
> > >
> > > warning: unknown warning option '-Woverride-init'; did you mean
> > > '-Woverride-module'? [-Wunknown-warning-option]
> > > 1 warning generated.
> > >
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Acked-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Thanks Nathan.
> 
> Andrew explained to me that this warning helps find bugs when
> developing the complicated (some would say crazy) set of macros that
> this pinctrl driver uses. It would be good to have this warning
> available in clang. Do we have a clang issue opened for that?
> 
> Acked-by: Joel Stanley <joel@jms.id.au>
> 
> Cheers,
> 
> Joel

Hi Joel,

I just opened https://github.com/ClangBuiltLinux/linux/issues/293.

I searched the LLVM issue tracker and haven't see any reference of this.
I can file an issue but if you are a little more familiar with this
warning, you are welcome to do it instead.

Thanks for the quick response,
Nathan

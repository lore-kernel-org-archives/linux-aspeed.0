From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Apr 2022 13:44:52 -0500
Subject: [PATCH] dt-bindings: pinctrl: aspeed: Drop referenced nodes in
 examples
In-Reply-To: <CACPK8XcQNJNyzqdjMQuCP+z-L-A9mcMqs-HJJrh9MscasV+D=A@mail.gmail.com>
References: <20220422192139.2592632-1-robh@kernel.org>
 <CACPK8XcQNJNyzqdjMQuCP+z-L-A9mcMqs-HJJrh9MscasV+D=A@mail.gmail.com>
Message-ID: <YmmPJLcI7PnsBtXn@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 27, 2022 at 08:40:31AM +0000, Joel Stanley wrote:
> On Fri, 22 Apr 2022 at 19:21, Rob Herring <robh@kernel.org> wrote:
> >
> > The additional nodes in the example referenced from the pinctrl node
> > 'aspeed,external-nodes' properties are either incorrect (aspeed,ast2500-lpc)
> > or not documented with a schema (aspeed,ast2500-gfx). There's no need to
> > show these nodes as part of the pinctrl example, so just remove them.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Nak.

I welcome patches that add schemas for the undocumented compatibles 
instead. Otherwise, I will be turning on this check by default and 
nagging people to fix them.

> This removes the information on how to use the bindings. Surely we
> prefer to over document rather than under document?

How is what the 'gfx' and 'lpc' nodes contain relevant to how the 
pinctrl binding works? If a user wants to know, then they should go look 
at the aspeed,ast2500-lpc/aspeed,ast2500-gfx bindings and their 
examples. Which brings up my secondary issue which is having the same 
example multiple times. It is multiple chances for errors (that I end 
up fixing).

How do we know the example is even correct without any schema checks? 
The 'framebuffer' node is not in a valid location is the most obvious 
thing I see.

Rob

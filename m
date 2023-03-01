From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 01 Mar 2023 14:28:59 +0800
Subject: [PATCH v4 5/5] dt-bindings: clock: ast2600: Add reset config
 for I3C
In-Reply-To: <CACPK8XcA_SES=Wo7vuWEJ4U5kTizM5brmb=6ELXD-taCFJQwgA@mail.gmail.com>
References: <20230228091638.206569-1-jk@codeconstruct.com.au>
	 <20230228091638.206569-6-jk@codeconstruct.com.au>
	 <CACPK8XcA_SES=Wo7vuWEJ4U5kTizM5brmb=6ELXD-taCFJQwgA@mail.gmail.com>
Message-ID: <cbbb99ce6125048667e4c41412710a61dc4d686f.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> > diff --git a/include/dt-bindings/clock/ast2600-clock.h
> > b/include/dt-bindings/clock/ast2600-clock.h
> > index b4d69103d722..b1c129977910 100644
> > --- a/include/dt-bindings/clock/ast2600-clock.h
> > +++ b/include/dt-bindings/clock/ast2600-clock.h
> > @@ -90,6 +90,12 @@
> > ?/* Only list resets here that are not part of a gate */
> 
> These definitions are part of a gate, yeah?

Well, no more "part of a gate" than all of the other definitions :)

All the defines in this section are references to individual bits in
the reset register banks in SCU040 & SCU050; the i3c set are the same
as the others there.

So I'm not sure what that comment is supposed to signify as to what
qualifies as a "gate" in the context of a reset...

Cheers,


Jeremy

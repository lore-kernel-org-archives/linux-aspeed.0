From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 05 Apr 2023 12:34:45 +0800
Subject: [PATCH v3 0/3] i3c dw,ast2600: Add a driver for the AST2600 i3c
 controller
In-Reply-To: <CACPK8XdLpg2H4a2nHo4PokfBc4r3D8MbK2-62jXkPXAq8Q03Rg@mail.gmail.com>
References: <20230331091501.3800299-1-jk@codeconstruct.com.au>
	 <CACPK8XdLpg2H4a2nHo4PokfBc4r3D8MbK2-62jXkPXAq8Q03Rg@mail.gmail.com>
Message-ID: <94e941a2895bbb40d7b87acd7de6525b8596b096.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> Given we have acks on the bindings, I think it's safe to send the
> device tree changes now so we can merge what you have in the upcoming
> merge window. If there's changes we can modify or revert.

OK, I'll get those into shape.

There is one dependency on this though, and unfortunately it requires
solving *two* of the known-hard problems in computer science:

Do we start at i3c0 or i3c1?

[i3c1 would match the schematic...]

Cheers,


Jeremy

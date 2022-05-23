From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 24 May 2022 01:44:37 +0200
Subject: [PATCH net v3] net: ftgmac100: Disable hardware checksum on
 AST2600
In-Reply-To: <CACPK8Xd5BLiz1ePwzirtxLvSL8V8EGmJuxB0GmxyyqBRK9mSdQ@mail.gmail.com>
References: <20220517092217.323060-1-joel@jms.id.au>
 <5630dd68ca5f31dafce3f92489761294ea589b16.camel@kernel.crashing.org>
 <CACPK8Xd5BLiz1ePwzirtxLvSL8V8EGmJuxB0GmxyyqBRK9mSdQ@mail.gmail.com>
Message-ID: <YowcZUX3lwAA6c5k@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > > The observed results:
> > >
> > >  1500 - good
> > >  1434 - bad
> > >  1400 - good
> > >  1410 - bad
> > >  1420 - good

Looking at these numbers, all the good cases a divisible by 4. All the
bad cases are not.

Could you extend the test to automatically test 64 through 1500?  Or
manually try 1499, 1498, 1497, 1496. Maybe the workaround is if the
packet length is divisible by 4 let the hardware do the checksum,
otherwise do it in software.

      Andrew

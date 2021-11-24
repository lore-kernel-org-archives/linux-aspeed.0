From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 24 Nov 2021 09:03:24 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}()
 helpers
In-Reply-To: <20211123154922.600fd3b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <20211122171739.03848154@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMuHMdWAAGrQUZN18cnDTDUUhuPNTZTFkRMe2Sbf+s7CedPSxA@mail.gmail.com>
 <637a4183861a1f2cdab52b7652bfa7ed33fbcdd2.camel@sipsolutions.net>
 <20211123154922.600fd3b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <05d4673a0343bfd83824d307e9cf8bf92e3814a6.camel@sipsolutions.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2021-11-23 at 15:49 -0800, Jakub Kicinski wrote:
> On Tue, 23 Nov 2021 17:24:15 +0100 Johannes Berg wrote:
> > > (*_replace_bits() seems to be useful, though)  
> > 
> > Indeed.
> > 
> > Also as I said in my other mail, the le32/be32/... variants are
> > tremendously useful, and they fundamentally cannot be expressed with the
> > FIELD_GET() or field_get() macros. IMHO this is a clear advantage to the
> 
> Can you elaborate?

Well, the way I see it, the only advantage of FIELD_GET() is that it
will auto-determine the type (based on the mask type.) This cannot work
if you need be/le conversions, because the be/le type annotations are
invisible to the compiler.

So obviously you could write a BE32_FIELD_GET(), but then really that's
equivalent to be32_get_bits() - note you you have to actually specify
the type in the macro name. I guess in theory you could make macros
where the type is an argument (like FIELD_GET_TYPE(be32, ...)), but I
don't see how that gains anything.

> > typed versions, and if you ask me we should get rid of the FIELD_GETand
> > FIELD_PREP entirely - difficult now, but at least let's not propagate
> > that?
> 
> I don't see why.

Just for being more regular, in the spirit of "there's exactly one
correct way of doing it" :)

johannes

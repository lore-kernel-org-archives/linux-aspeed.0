From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 23 Nov 2021 17:24:15 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}()
 helpers
In-Reply-To: <CAMuHMdWAAGrQUZN18cnDTDUUhuPNTZTFkRMe2Sbf+s7CedPSxA@mail.gmail.com>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <20211122171739.03848154@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMuHMdWAAGrQUZN18cnDTDUUhuPNTZTFkRMe2Sbf+s7CedPSxA@mail.gmail.com>
Message-ID: <637a4183861a1f2cdab52b7652bfa7ed33fbcdd2.camel@sipsolutions.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2021-11-23 at 09:36 +0100, Geert Uytterhoeven wrote:


Ah, here's your comment wrt. which one is nicer :)

> > > We have the upper-case (constant) versions, and already
> > > {u32,...}_get_bits()/etc.
> 
> TBH, I don't like the *_get_bits() API: in general, u32_get_bits() does
> the same as FIELD_GET(), but the order of the parameters is different?

I don't really see how "the order of parameters is different" is a
downside? Yeah it means if you're used to FIELD_GET() then you'll
retrain, but ...?

> (*_replace_bits() seems to be useful, though)

Indeed.

Also as I said in my other mail, the le32/be32/... variants are
tremendously useful, and they fundamentally cannot be expressed with the
FIELD_GET() or field_get() macros. IMHO this is a clear advantage to the
typed versions, and if you ask me we should get rid of the FIELD_GETand
FIELD_PREP entirely - difficult now, but at least let's not propagate
that?

johannes

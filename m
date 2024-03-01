From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Mar 2024 09:18:01 +0100
Subject: [PATCH v6] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema
In-Reply-To: <e55aa1321ccac8e6391ab65a5a439b49d265bfce.camel@codeconstruct.com.au>
References: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
 <c2060450-4b76-4740-afe4-d14717245f01@linaro.org> <16ddd99007176da3f84462de217cb76c8fa4e1bd.camel@codeconstruct.com.au>
 <CAMRc=MeEyo7y-G1saydxtTRedNtHPaEeLANuzXt6KsiDU2jOWw@mail.gmail.com> <e55aa1321ccac8e6391ab65a5a439b49d265bfce.camel@codeconstruct.com.au>
Message-ID: <CAMRc=Mfa1uUhkPNpLdcMsGC4=G+_MGzaxXRL7UVdfKJD_zF0+w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 1, 2024 at 12:23?AM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Thu, 2024-02-29 at 09:52 +0100, Bartosz Golaszewski wrote:
> > On Thu, Feb 29, 2024 at 4:21?AM Andrew Jeffery
> > <andrew@codeconstruct.com.au> wrote:
> > >
> > > On Wed, 2024-02-28 at 08:47 +0100, Krzysztof Kozlowski wrote:
> > > >
> > > > You still have way too many examples. One is enough, two is still okay.
> > > > We really do not want more of examples with minor differences.
> > >
> > > Noted, I'll keep them to a minimum in the future.
> > >
> >
> > As in: I'll still send a v7? I can trim the examples when applying,
> > just tell me which ones to drop.
>
> Ah, thanks. I wasn't planning to send a v7 given the R-b tag from
> Krzysztof for v6. I intended for "in the future" to mean for patches
> converting other bindings to DT schema. But if you're keen to trim some
> examples out I'd drop the aspeed,ast2400-gpio and aspeed,ast2500-gpio
> nodes, keeping just the aspeed,ast2600-gpio example.
>
> Andrew

It's ok, I applied it as is.

Bart

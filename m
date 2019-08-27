From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Aug 2019 09:41:20 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_4/4]_dt-bindings/watchdog:_Add_access=5Fcs0_opti?=
 =?UTF-8?Q?on_for_alt-boot?=
In-Reply-To: <d040fee1-d12d-9ac9-a72a-e76137a4579f@roeck-us.net>
References: <20190826104636.19324-1-i.mikhaylov@yadro.com>
 <20190826104636.19324-5-i.mikhaylov@yadro.com>
 <f33aa4b8-6d06-4226-8859-ce21a4b8728b@www.fastmail.com>
 <d040fee1-d12d-9ac9-a72a-e76137a4579f@roeck-us.net>
Message-ID: <fab64830-69be-44fb-9e6f-ed8783b821a4@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 27 Aug 2019, at 09:38, Guenter Roeck wrote:
> On 8/26/19 4:57 PM, Andrew Jeffery wrote:
> > 
> > 
> > On Mon, 26 Aug 2019, at 20:17, Ivan Mikhaylov wrote:
> >> The option for the ast2400/2500 to get access to CS0 at runtime.
> >>
> >> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> >> ---
> >>   Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> >> b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> >> index c5077a1f5cb3..023a9b578df6 100644
> >> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> >> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> >> @@ -34,6 +34,13 @@ Optional properties:
> >>                   engine is responsible for this.
> >>   
> >>    - aspeed,alt-boot:    If property is present then boot from alternate
> >> block.
> >> +                       At alternate side 'access_cs0' sysfs file
> >> provides:
> > 
> > Why are we talking about sysfs in the devicetree binding? This patch
> > doesn't seem right to me.
> > 
> 
> Correct; this is the wrong document. The attribute also will need
> to be better explained. "At alternate side" does not explain (at
> least not at all clearly enough) that the attribute only exists
> if the system has booted from the alternate flash / block.
> 
> > Also if we're not supporting the aspeed,alt-boot property we should
> > probably document it as deprecated rather than making it disappear,
> > unless you're going to fix the systems that are using it.
> > 
> Sorry, you lost me here. Where is it made to disappear ?

Oh, hah, I read the bullet '-' as a diff marker. Maybe I should go back to
bed!

Andrew

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 03 May 2023 12:43:00 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <20230503011920.GB31464@dragon>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <2783a3ba-8fcb-7e5f-3147-91d02e573ba4@kernel.org>
 <20230503011920.GB31464@dragon>
Message-ID: <89dfb3e4-4009-4ed1-8cb0-d6ee16928caa@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 3, 2023, at 03:19, Shawn Guo wrote:
> On Tue, May 02, 2023 at 10:02:03PM +0200, Krzysztof Kozlowski wrote:
>> On 02/05/2023 21:40, Rob Herring wrote:
>> 
>> If I remember correctly, Vybrid are a bit closer to iMX than to LS
>> (Layerscape), but it should be Shawn's call (+Cc).
>
> I would suggest to have all Freescale/NXP platforms in a single
> directory, which includes all mxs, imx, fsl ones.

I'd go with 'nxp' for all of those then, and also include the lpc* ones.

It's fine to stay with historic names if changing it causes problems,
but if we are going to change anyway, then let's call it the current
owner's name. It will get messy again soon enough with the next round
of mergers and acquisitions.

      Arnd

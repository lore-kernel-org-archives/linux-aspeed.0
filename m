From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 02 May 2023 10:15:03 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
Message-ID: <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 25, 2023, at 17:57, Rob Herring wrote:
> On Tue, Apr 25, 2023 at 2:28?AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> Does your script also cater for .dts files not matching any pattern,
>> but including a .dtsi file that does match a pattern?
>
> I assume I built everything after moving, but maybe not...
>
> That's all just "details". First, we need agreement on a) moving
> things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> been stuck on a) for being 'too much churn'.

Sorry for missing most of the discussion last week. The script sounds
fine to me, the only reason I didn't want to do this in the past is that
we had the plan to move platforms out of the kernel tree to an external
repository and I wanted to do this platform at a time and also only move
each one once. I don't think that is going to happen anytime soon now,
so let's just do your script.

Can you send me the script and/or a pull request of the resulting
tree based on my soc/dt branch? Everything is merged upstream,
and I think git-merge would handle the remaining merges with any
other changes in mainline.

        Arnd

From: Ansuel Smith <ansuelsmth@gmail.com>
Date: Tue, 25 Apr 2023 00:23:54 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
Message-ID: <CA+_ehUw3eAEHRsi1ATSKeK4jtX+EoVSwUodNL3bcpTJaX-r9cA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Il giorno mar 25 apr 2023 alle ore 00:10 Rob Herring
<robh+dt@kernel.org> ha scritto:
>
> On Tue, Mar 29, 2022 at 8:27?AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > On Tue, Mar 29, 2022 at 03:20:18PM +0200, Krzysztof Kozlowski wrote:
> > > On 28/03/2022 02:09, Ansuel Smith wrote:
> > > > Hi,
> > > > as the title say, the intention of this ""series"" is to finally categorize
> > > > the ARM dts directory in subdirectory for each oem.
> > > >
> > > > The main reason for this is that it became unpractical to handle 2600
> > > > dts files and try to even understand/edit/check the situation for a
> > > > specific target.
> > > >
> > > > In arm64 we already have this kind of separation and I honestly think
> > > > that this was never proposed for ARM due to the fact that there are
> > > > 2600+ files to sort and the fact that it will be a mess to merge this
> > > > entirely but IMHO with a little bit of effort we can finally solve this
> > > > problem and have a well organized directory just like arm64.
> > > >
> > > > Some prerequisite on how this work was done:
> > > > - This comes entirely from a python script created by me for the task.
> > > >   linked here [1]
> > > > - I had to manually categorize all the different arch in the makefile
> > > >   based on the oem. I searched every arch on the internet trying to
> > > >   understand the correct oem. I hope they are correct but I would love
> > > >   some comments about them.
> > > > - This current ""series"" is all squashed in one big commit to better
> > > >   receive comments for this. The final version ideally would have all
> > > >   changes in separate commits. The script can already do this, it's just
> > > >   commented.
> > > >
> > > > Here is a list of some discoveries while doing all the sorting.
> > > > These are totally additional reason why we need this.
> > > >
> > > > While creating the script I discovered some funny things:
> > > > - We have orphan dts! There are dts that are never compiled and are
> > > >   there just for reference. We would never have noticed this without this
> > > >   change and probably nobody noticed it. They are currently all listed
> > > >   in the python script.
> > > > - We have dtsi shared across different oem. My current solution for them
> > > >   is: NOT SORT THEM and leave them in the generic directory and create a
> > > >   link in each oem dts that points to these dtsi. This is to try in
> > > >   every way possible to skip any additional changes to the dts.
> > > >   Current dtsi that suffers from this are only 3. (listed in the script)
> > > > - arm64 dts and dtsi reference ARM dts. Obviously this change would cause
> > > >   broken include for these special dtsi. The script creates a dependency
> > > >   table of the entire arm64 directory and fix every broken dependency
> > > >   (hoping they all use a sane include logic... regex is used to parse
> > > >   all the different dependency)
> > > >
> > > > So in short the script does the following steps:
> > > > 1. Enumerate all the action to do... (dts to move, scan dependency for
> > > >    the dts...)
> > > > 2. Generate the arm64 dependency
> > > > 3. Creates the Makefile
> > > > 4. Generate the Makefiles for the current oem
> > > > 5. Move all the related dts and dtsi for the current oem
> > > > 6. Check broken dependency and fix them by editing the dts and writing
> > > >    the correct include (or fix any symbolic link)
> > > >
> > > > This is an output that describes all the things done by the script [2]
> > > >
> > > > I really hope I didn't commit any logic mistake in the script but most
> > > > of the work should be done.
> > > >
> > >
> > > +Cc Arnd and Olof,
> > >
> > > Ansuel,
> > > Thanks for you patch. Please cc the SoC maintainers in such submissions.
> > > It seems that you got some quite nice discussion, but still the core
> > > folks are not Cced, so no one would be able to take your patch...
> > >
> >
> > I had some problem with gmail and sending mail too much users. I put Rob
> > and You and all the various list to try to workaround the "gmail spam
> > protection"
> >
> > > I am pretty sure we were discussing such split idea in the past and it
> > > did not get traction, but I cannot recall the exact discussion.
> > >
> >
> > I think the main issue here is how to handle bot and how problematic is
> > to merge this. As written in the cover letter the final version of this
> > should be a big series of 50+ patch with every commit specific to each
> > oem. In theory we should be able to merge the different oem separately
> > and try to at least start the categorization.
> > Another idea I got to at least have a "migration path" is to convert
> > every dts in the dts/ directory to a symbolic link that target the dts
> > in the correct oem. But I assume that would fix only part of the problem
> > and git am will still be problematic.
>
> I have a script[1] that does the conversion written the last time this
> came up. Just have to agree on directory names. I think the easiest
> would be for Arnd/Olof to run it at the end of a merge window before
> rc1.
>
> I'm very much in favor of this happening especially before *any*
> overlays are added to add to the mess (it's probably already
> happened).
>
> Rob
>
> [1] https://lore.kernel.org/all/20181204183649.GA5716 at bogus/

Hi Rob,
thanks for recovering this. I remember also providing a script.

Anyway considering the amount of stuff to move, I feel like some
OEM might be problematic to move due to rebase and merging problems.

We should consider accepting moving only some and keep other
in the unsorted path. And move them at the first time possible with
the help of the maintainers.

One main blocker of this is some qcom dts that are linked to arm64
directory, so for some dts special care is needed.

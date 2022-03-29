From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 29 Mar 2022 15:20:18 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <20220328000915.15041-1-ansuelsmth@gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
Message-ID: <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 28/03/2022 02:09, Ansuel Smith wrote:
> Hi,
> as the title say, the intention of this ""series"" is to finally categorize
> the ARM dts directory in subdirectory for each oem.
> 
> The main reason for this is that it became unpractical to handle 2600
> dts files and try to even understand/edit/check the situation for a
> specific target.
> 
> In arm64 we already have this kind of separation and I honestly think
> that this was never proposed for ARM due to the fact that there are
> 2600+ files to sort and the fact that it will be a mess to merge this
> entirely but IMHO with a little bit of effort we can finally solve this
> problem and have a well organized directory just like arm64.
> 
> Some prerequisite on how this work was done:
> - This comes entirely from a python script created by me for the task.
>   linked here [1]
> - I had to manually categorize all the different arch in the makefile
>   based on the oem. I searched every arch on the internet trying to
>   understand the correct oem. I hope they are correct but I would love
>   some comments about them.
> - This current ""series"" is all squashed in one big commit to better
>   receive comments for this. The final version ideally would have all
>   changes in separate commits. The script can already do this, it's just
>   commented.
> 
> Here is a list of some discoveries while doing all the sorting.
> These are totally additional reason why we need this.
> 
> While creating the script I discovered some funny things:
> - We have orphan dts! There are dts that are never compiled and are
>   there just for reference. We would never have noticed this without this
>   change and probably nobody noticed it. They are currently all listed
>   in the python script.
> - We have dtsi shared across different oem. My current solution for them
>   is: NOT SORT THEM and leave them in the generic directory and create a
>   link in each oem dts that points to these dtsi. This is to try in
>   every way possible to skip any additional changes to the dts.
>   Current dtsi that suffers from this are only 3. (listed in the script)
> - arm64 dts and dtsi reference ARM dts. Obviously this change would cause
>   broken include for these special dtsi. The script creates a dependency
>   table of the entire arm64 directory and fix every broken dependency
>   (hoping they all use a sane include logic... regex is used to parse
>   all the different dependency)
> 
> So in short the script does the following steps:
> 1. Enumerate all the action to do... (dts to move, scan dependency for
>    the dts...)
> 2. Generate the arm64 dependency
> 3. Creates the Makefile
> 4. Generate the Makefiles for the current oem
> 5. Move all the related dts and dtsi for the current oem
> 6. Check broken dependency and fix them by editing the dts and writing
>    the correct include (or fix any symbolic link)
> 
> This is an output that describes all the things done by the script [2]
> 
> I really hope I didn't commit any logic mistake in the script but most
> of the work should be done.
> 

+Cc Arnd and Olof,

Ansuel,
Thanks for you patch. Please cc the SoC maintainers in such submissions.
It seems that you got some quite nice discussion, but still the core
folks are not Cced, so no one would be able to take your patch...

I am pretty sure we were discussing such split idea in the past and it
did not get traction, but I cannot recall the exact discussion.

To me the idea is good but will cause huge `git am` conflicts.
Cherry-picks, backports and merges should nicely detect path renames,
but git am (and b4 am) I think cannot.

Best regards,
Krzysztof

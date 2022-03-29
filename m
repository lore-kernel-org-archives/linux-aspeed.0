From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 29 Mar 2022 19:02:04 +1030
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <YkK691VG6ON/6Ysn@atomide.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
 <YkK691VG6ON/6Ysn@atomide.com>
Message-ID: <a2542d9f-581a-49be-8e70-722fd98ab6f1@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 29 Mar 2022, at 18:23, Tony Lindgren wrote:
> Hi,
>
> * Daniel Palmer <daniel@0x0f.com> [220328 08:53]:
>> Hi Ansuel
>> 
>> On Mon, 28 Mar 2022 at 09:09, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>> >
>> > Hi,
>> > as the title say, the intention of this ""series"" is to finally categorize
>> > the ARM dts directory in subdirectory for each oem.
>> 
>> While I agree with this change and think it's for the good (browsing
>> the ARM dts directory at the moment is frustrating..) I think
>> buildroot and others need to be told about this as it'll potentially
>> break their kernel build scripting for ARM and probably messes up the
>> configs they have for existing boards.
>
> Yeah.. And ideally this would be done in smaller steps as these will
> conflict with all the other pending patches.
>
> For example, I have a pile of pending omap clock clean-up dts patches
> posted and tested waiting for v5.19-rc1 to apply. I'd rather not start
> redoing or fixing up the patches with sed :)
>
> What I'd like to have see is that at some point when suitable we move
> one machine at a time with a script if possible.. Maybe the dtb files
> generated would need to remain in the current directory until all of
> the machine dts files are moved? That should help with the build
> scripting too probably :)

There's probably some reason not to, but could we symlink the new paths 
in the subdirectories to the existing files to handle the transition? 
Then do the move to remove the symlinks at some future point.

Andrew

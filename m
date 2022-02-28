From: Jakob Koschel <jakobkoschel@gmail.com>
Date: Mon, 28 Feb 2022 23:05:26 +0100
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <0b65541a-3da7-dc35-690a-0ada75b0adae@amd.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <0b65541a-3da7-dc35-690a-0ada75b0adae@amd.com>
Message-ID: <192A6D7F-E803-47AE-9C7A-267B4E87C856@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 28. Feb 2022, at 21:56, Christian K?nig <christian.koenig@amd.com> wrote:
> 
> 
> 
> Am 28.02.22 um 21:42 schrieb James Bottomley:
>> On Mon, 2022-02-28 at 21:07 +0100, Christian K?nig wrote:
>>> Am 28.02.22 um 20:56 schrieb Linus Torvalds:
>>>> On Mon, Feb 28, 2022 at 4:19 AM Christian K?nig
>>>> <christian.koenig@amd.com> wrote:
>>>> [SNIP]
>>>> Anybody have any ideas?
>>> I think we should look at the use cases why code is touching (pos)
>>> after the loop.
>>> 
>>> Just from skimming over the patches to change this and experience
>>> with the drivers/subsystems I help to maintain I think the primary
>>> pattern looks something like this:
>>> 
>>> list_for_each_entry(entry, head, member) {
>>>      if (some_condition_checking(entry))
>>>          break;
>>> }
>>> do_something_with(entry);

There are other cases where the list iterator variable is used after the loop
Some examples:

- list_for_each_entry_continue() and list_for_each_entry_from().

- (although very rare) the head is actually of the correct struct type.
		(ppc440spe_get_group_entry(): drivers/dma/ppc4xx/adma.c:1436)

- to use pos->list for example for list_add_tail():
		(add_static_vm_early(): arch/arm/mm/ioremap.c:107)

If the scope of the list iterator is limited those still need fixing in a different way.

>> 
>> Actually, we usually have a check to see if the loop found anything,
>> but in that case it should something like
>> 
>> if (list_entry_is_head(entry, head, member)) {
>>     return with error;
>> }
>> do_somethin_with(entry);
>> 
>> Suffice?  The list_entry_is_head() macro is designed to cope with the
>> bogus entry on head problem.
> 
> That will work and is also what people already do.
> 
> The key problem is that we let people do the same thing over and over again with slightly different implementations.
> 
> Out in the wild I've seen at least using a separate variable, using a bool to indicate that something was found and just assuming that the list has an entry.
> 
> The last case is bogus and basically what can break badly.
> 
> If we would have an unified macro which search for an entry combined with automated reporting on patches to use that macro I think the potential to introduce such issues will already go down massively without auditing tons of existing code.

Having a unified way to do the same thing would indeed be great.

> 
> Regards,
> Christian.
> 
>> 
>> James
>> 
>> 
> 

- Jakob


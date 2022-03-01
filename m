From: Christian König <christian.koenig@amd.com>
Date: Tue, 1 Mar 2022 08:03:26 +0100
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <ade13f419519350e460e7ef1e64477ec72e828ed.camel@HansenPartnership.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <0b65541a-3da7-dc35-690a-0ada75b0adae@amd.com>
 <ade13f419519350e460e7ef1e64477ec72e828ed.camel@HansenPartnership.com>
Message-ID: <3d37084e-72d4-d3a5-ec8d-df1ac1758fad@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am 28.02.22 um 22:13 schrieb James Bottomley:
> On Mon, 2022-02-28 at 21:56 +0100, Christian K?nig wrote:
>> Am 28.02.22 um 21:42 schrieb James Bottomley:
>>> On Mon, 2022-02-28 at 21:07 +0100, Christian K?nig wrote:
>>>> Am 28.02.22 um 20:56 schrieb Linus Torvalds:
>>>>> On Mon, Feb 28, 2022 at 4:19 AM Christian K?nig
>>>>> <christian.koenig@amd.com> wrote:
>>>>> [SNIP]
>>>>> Anybody have any ideas?
>>>> I think we should look at the use cases why code is touching
>>>> (pos)
>>>> after the loop.
>>>>
>>>> Just from skimming over the patches to change this and experience
>>>> with the drivers/subsystems I help to maintain I think the
>>>> primary pattern looks something like this:
>>>>
>>>> list_for_each_entry(entry, head, member) {
>>>>        if (some_condition_checking(entry))
>>>>            break;
>>>> }
>>>> do_something_with(entry);
>>> Actually, we usually have a check to see if the loop found
>>> anything, but in that case it should something like
>>>
>>> if (list_entry_is_head(entry, head, member)) {
>>>       return with error;
>>> }
>>> do_somethin_with(entry);
>>>
>>> Suffice?  The list_entry_is_head() macro is designed to cope with
>>> the bogus entry on head problem.
>> That will work and is also what people already do.
>>
>> The key problem is that we let people do the same thing over and
>> over again with slightly different implementations.
>>
>> Out in the wild I've seen at least using a separate variable, using
>> a bool to indicate that something was found and just assuming that
>> the list has an entry.
>>
>> The last case is bogus and basically what can break badly.
> Yes, I understand that.  I'm saying we should replace that bogus checks
> of entry->something against some_value loop termination condition with
> the list_entry_is_head() macro.  That should be a one line and fairly
> mechanical change rather than the explosion of code changes we seem to
> have in the patch series.

Yes, exactly that's my thinking as well.

Christian.

>
> James
>
>


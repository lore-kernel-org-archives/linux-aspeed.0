From: Mike Rapoport <rppt@kernel.org>
Date: Mon, 28 Feb 2022 23:59:07 +0200
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/6=5D_treewide=3A_remove_using?=
 =?US-ASCII?Q?_list_iterator_after_loop_body_as_a_ptr?=
In-Reply-To: <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
Message-ID: <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On February 28, 2022 10:42:53 PM GMT+02:00, James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>On Mon, 2022-02-28 at 21:07 +0100, Christian K?nig wrote:
>> Am 28.02.22 um 20:56 schrieb Linus Torvalds:
>> > On Mon, Feb 28, 2022 at 4:19 AM Christian K?nig
>> > <christian.koenig@amd.com> wrote:
>> > > I don't think that using the extra variable makes the code in any
>> > > way
>> > > more reliable or easier to read.
>> > So I think the next step is to do the attached patch (which
>> > requires
>> > that "-std=gnu11" that was discussed in the original thread).
>> > 
>> > That will guarantee that the 'pos' parameter of
>> > list_for_each_entry()
>> > is only updated INSIDE the for_each_list_entry() loop, and can
>> > never
>> > point to the (wrongly typed) head entry.
>> > 
>> > And I would actually hope that it should actually cause compiler
>> > warnings about possibly uninitialized variables if people then use
>> > the
>> > 'pos' pointer outside the loop. Except
>> > 
>> >   (a) that code in sgx/encl.c currently initializes 'tmp' to NULL
>> > for
>> > inexplicable reasons - possibly because it already expected this
>> > behavior
>> > 
>> >   (b) when I remove that NULL initializer, I still don't get a
>> > warning,
>> > because we've disabled -Wno-maybe-uninitialized since it results in
>> > so
>> > many false positives.
>> > 
>> > Oh well.
>> > 
>> > Anyway, give this patch a look, and at least if it's expanded to do
>> > "(pos) = NULL" in the entry statement for the for-loop, it will
>> > avoid the HEAD type confusion that Jakob is working on. And I think
>> > in a cleaner way than the horrid games he plays.
>> > 
>> > (But it won't avoid possible CPU speculation of such type
>> > confusion. That, in my opinion, is a completely different issue)
>> 
>> Yes, completely agree.
>> 
>> > I do wish we could actually poison the 'pos' value after the loop
>> > somehow - but clearly the "might be uninitialized" I was hoping for
>> > isn't the way to do it.
>> > 
>> > Anybody have any ideas?
>> 
>> I think we should look at the use cases why code is touching (pos)
>> after the loop.
>> 
>> Just from skimming over the patches to change this and experience
>> with the drivers/subsystems I help to maintain I think the primary
>> pattern looks something like this:
>> 
>> list_for_each_entry(entry, head, member) {
>>      if (some_condition_checking(entry))
>>          break;
>> }
>> do_something_with(entry);
>
>
>Actually, we usually have a check to see if the loop found anything,
>but in that case it should something like
>
>if (list_entry_is_head(entry, head, member)) {
>    return with error;
>}
>do_somethin_with(entry);
>
>Suffice?  The list_entry_is_head() macro is designed to cope with the
>bogus entry on head problem.

Won't suffice because the end goal of this work is to limit scope of entry only to loop. Hence the need for additional variable.

Besides, there are no guarantees that people won't do_something_with(entry) without the check or won't compare entry to NULL to check if the loop finished with break or not.

>James


-- 
Sincerely yours,
Mike

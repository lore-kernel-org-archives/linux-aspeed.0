From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 28 Feb 2022 22:32:28 -0800
Subject: [PATCH 2/6] treewide: remove using list iterator after loop
 body as a ptr
In-Reply-To: <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <FC710A1A-524E-481B-A668-FC258F529A2E@gmail.com>
 <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
Message-ID: <20220228223228.24cf3fd4@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 28 Feb 2022 16:41:04 -0800 Linus Torvalds wrote:
> So yes, initially my idea had been to just move the iterator entirely
> inside the macro. But specifying the type got so ugly that I think
> that
> 
>         typeof (pos) pos
> 
> trick inside the macro really ends up giving us the best of all worlds:
> 
>  (a) let's us keep the existing syntax and code for all the nice cases
> that did everything inside the loop anyway
> 
>  (b) gives us a nice warning for any normal use-after-loop case
> (unless you explicitly initialized it like that
> sgx_mmu_notifier_release() function did for no good reason
> 
>  (c) also guarantees that even if you don't get a warning,
> non-converted (or newly written) bad code won't actually _work_
> 
> so you end up getting the new rules without any ambiguity or mistaken

I presume the goal is that we can do this without changing existing
code? Otherwise actually moving the iterator into the loop body would
be an option, by creating a different hidden variable:

#define list_iter(head)						\
	for (struct list head *_l = (head)->next; _l != (head); _l = _l->next)

#define list_iter_entry(var, member)		\
	list_entry(_l, typeof(*var), member)


	list_iter(&p->a_head) {
		struct entry *e = list_iter_entry(e, a_member);

		/* use e->... */
	}


Or we can slide into soft insanity and exploit one of Kees'es tricks
to encode the type of the entries "next to" the head:

#define LIST_HEAD_MEM(name, type)			\
	union {						\
		struct list_head name;			\
		type *name ## _entry;			\
	}

struct entry {
	struct list_head a_member;
};

struct parent {
	LIST_HEAD_MEM(a_head, struct entry);
};

#define list_for_each_magic(pos, head, member)				\
	for (typeof(**(head ## _entry)) *pos = list_first_entry(head, typeof(**(head ## _entry)), member); \
	     &pos->member != (head);					\
	     pos = list_next_entry(pos, member))


	list_for_each_magic(e, &p->a_head, a_member) {
		/* use e->... */
	}


I'll show myself out...

From: Jakob Koschel <jakobkoschel@gmail.com>
Date: Thu, 3 Mar 2022 08:32:31 +0100
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <39404befad5b44b385698ff65465abe5@AcuMS.aculab.com>
References: <1077f17e50d34dc2bbfdf4e52a1cb2fd@AcuMS.aculab.com>
 <20220303022729.9321-1-xiam0nd.tong@gmail.com>
 <39404befad5b44b385698ff65465abe5@AcuMS.aculab.com>
Message-ID: <A568BD90-FE81-4740-B1D3-C795EB636A5A@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 3. Mar 2022, at 05:58, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> From: Xiaomeng Tong
>> Sent: 03 March 2022 02:27
>> 
>> On Wed, 2 Mar 2022 14:04:06 +0000, David Laight
>> <David.Laight@ACULAB.COM> wrote:
>>> I think that it would be better to make any alternate loop macro
>>> just set the variable to NULL on the loop exit.
>>> That is easier to code for and the compiler might be persuaded to
>>> not redo the test.
>> 
>> No, that would lead to a NULL dereference.
> 
> Why, it would make it b ethe same as the 'easy to use':
> 	for (item = head; item; item = item->next) {
> 		...
> 		if (...)
> 			break;
> 		...
> 	}
> 	if (!item)
> 		return;
> 
>> The problem is the mis-use of iterator outside the loop on exit, and
>> the iterator will be the HEAD's container_of pointer which pointers
>> to a type-confused struct. Sidenote: The *mis-use* here refers to
>> mistakely access to other members of the struct, instead of the
>> list_head member which acutally is the valid HEAD.
> 
> The problem is that the HEAD's container_of pointer should never
> be calculated at all.
> This is what is fundamentally broken about the current definition.
> 
>> IOW, you would dereference a (NULL + offset_of_member) address here.
> 
> Where?
> 
>> Please remind me if i missed something, thanks.
>> 
>> Can you share your "alternative definitions" details? thanks!
> 
> The loop should probably use as extra variable that points
> to the 'list node' in the next structure.
> Something like:
> 	for (xxx *iter = head->next;
> 		iter == &head ? ((item = NULL),0) : ((item = list_item(iter),1));
> 		iter = item->member->next) {
> 	   ...
> With a bit of casting you can use 'item' to hold 'iter'.

I think this would make sense, it would mean you only assign the containing
element on valid elements.

I was thinking something along the lines of:

#define list_for_each_entry(pos, head, member)					\
	for (struct list_head *list = head->next, typeof(pos) pos;	\
	     list == head ? 0 : (( pos = list_entry(pos, list, member), 1));	\
	     list = list->next)

Although the initialization block of the for loop is not valid C, I'm
not sure there is any way to declare two variables of a different type
in the initialization part of the loop.

I believe all this does is get rid of the &pos->member == (head) check
to terminate the list.
It alone will not fix any of the other issues that using the iterator
variable after the loop currently has.


AFAIK Adri?n Moreno is working on doing something along those lines
for the list iterator in openvswitch (that was similar to the kernel
one before) [1].

I *think* they don't declare 'pos' within the loop which we *do want*
to avoid any uses of it after the loop.
(If pos is not declared in the initialization block, shadowing the
*outer* pos, it would just point to the last element of the list or stay
uninitialized if the list is empty).


[1] https://www.mail-archive.com/ovs-dev at openvswitch.org/msg63497.html


> 
>> 
>>> OTOH there may be alternative definitions that can be used to get
>>> the compiler (or other compiler-like tools) to detect broken code.
>>> Even if the definition can't possibly generate a working kerrnel.
>> 
>> The "list_for_each_entry_inside(pos, type, head, member)" way makes
>> the iterator invisiable outside the loop, and would be catched by
>> compiler if use-after-loop things happened.
> 
> It is also a compete PITA for anything doing a search.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

- Jakob

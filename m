From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 16 Apr 2019 20:49:31 -0700
Subject: [PATCH v2 00/21] Convert hwmon documentation to ReST
In-Reply-To: <20190416225836.1d5953bc@coco.lan>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net> <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net> <20190412100451.6fe49de7@lwn.net>
 <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
 <20190416141949.09b48789@lwn.net> <20190416203114.GB25517@roeck-us.net>
 <20190416225836.1d5953bc@coco.lan>
Message-ID: <1d8a4410-4a8c-7b7a-141d-d2495cc66749@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/16/19 6:58 PM, Mauro Carvalho Chehab wrote:
> Em Tue, 16 Apr 2019 13:31:14 -0700
> Guenter Roeck <linux@roeck-us.net> escreveu:
> 
>> On Tue, Apr 16, 2019 at 02:19:49PM -0600, Jonathan Corbet wrote:
>>> On Fri, 12 Apr 2019 20:09:16 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>    
>>>> The big real-world question is: Is the series good enough for you to accept,
>>>> or do you expect some level of user/kernel separation ?
>>>
>>> I guess it can go in; it's forward progress, even if it doesn't make the
>>> improvements I would like to see.
>>>
>>> The real question, I guess, is who should take it.  I've been seeing a
>>> fair amount of activity on hwmon, so I suspect that the potential for
>>> conflicts is real.  Perhaps things would go smoother if it went through
>>> your tree?
>>>    
>> We'll see a number of conflicts, yes. In terms of timing, this is probably
>> the worst release in the last few years to make such a change. I currently
>> have 9 patches queued in hwmon-next which touch Documentation/hwmon.
>> Of course the changes made in those are all not ReST compatible, and I have
>> no idea what to look out for to make it compatible. So this is going to be
>> fun (in a negative sense) either way.
>>
>> I don't really have a recommendation at this point; I think the best I could
>> do to take the patches which don't generate conflicts and leave the rest
>> alone. But that would also be bad, since the new index file would not match
>> reality. No idea, really, what the best or even a useful approach would be.
>>
>> Maybe automated changes like this (assuming they are indeed automated)
>> can be generated and pushed right after a commit window closes. Would
>> that by any chance be possible ?
> 
> No, those patches are hand-maid, but I can surely rebase it on the top of
> your tree. Is your tree already merged at linux-next, or should I use some
> other branch/tree for rebase?
> 

linux-next merges hwmon-next. next-20190416 is missing one patch which touches
Documentation/hwmon, but that should be easy to deal with.

Thanks,
Guenter

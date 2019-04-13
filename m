From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 12 Apr 2019 20:09:16 -0700
Subject: [PATCH v2 00/21] Convert hwmon documentation to ReST
In-Reply-To: <20190412100451.6fe49de7@lwn.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net> <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net> <20190412100451.6fe49de7@lwn.net>
Message-ID: <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/12/19 9:04 AM, Jonathan Corbet wrote:
> On Thu, 11 Apr 2019 14:07:31 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> While nobody does such split, IMHO, the best would be to keep the
>>> information outside Documentation/admin-guide. But hey! You're
>>> the Doc maintainer. If you prefer to move, I'm perfectly fine
>>> with that.
>>>    
>>
>> Same here, but please don't move the files which are kernel facing only.
> 
> Well, let's step back and think about this.  Who is the audience for
> these documents?  That will tell us a lot about where they should really
> be.
> 
> What I would prefer to avoid is the status quo where *everything* is in
> the top-level directory, and where documents are organized for the
> convenience of their maintainers rather than of their readers.  But
> sometimes I feel like I'm alone in that desire...:)
> 

The big real-world question is: Is the series good enough for you to accept,
or do you expect some level of user/kernel separation ?

Guenter

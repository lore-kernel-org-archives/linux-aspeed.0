From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu, 6 Jan 2022 19:35:56 +0100
Subject: [PATCH] fsi: Aspeed: Fix a potential double free
In-Reply-To: <f2ba50fd-5c6b-e905-17ed-541dcc98c6c1@roeck-us.net>
References: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
 <YcldM9sgYdjMYMtH@kroah.com> <20220106081418.GH7674@kadam>
 <f2ba50fd-5c6b-e905-17ed-541dcc98c6c1@roeck-us.net>
Message-ID: <edd19014-3b99-fa0b-912b-e058c14401d8@wanadoo.fr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le 06/01/2022 ? 18:25, Guenter Roeck a ?crit?:
> On 1/6/22 12:14 AM, Dan Carpenter wrote:
>> On Mon, Dec 27, 2021 at 07:29:07AM +0100, Greg KH wrote:
>>> On Sun, Dec 26, 2021 at 05:56:02PM +0100, Christophe JAILLET wrote:
>>>> 'aspeed' is a devm_alloc'ed, so there is no need to free it 
>>>> explicitly or
>>>> there will be a double free().
>>>
>>> A struct device can never be devm_alloced for obvious reasons.? Perhaps
>>> that is the real problem here?
>>>
>>
>> I don't understand how "aspeed" is a struct device.
>>
> 
> -static void aspeed_master_release(struct device *dev)
> -{
> -??? struct fsi_master_aspeed *aspeed =
> -??????? to_fsi_master_aspeed(dev_to_fsi_master(dev));
> -
> -??? kfree(aspeed);
> -}
> 
> So "dev" is embedded in struct fsi_master, and struct fsi_master is 
> embedded
> in struct fsi_master_aspeed. Since "struct device" is embedded, the data
> structure embedding it must be released with the release function, as is 
> done
> here. The problem is indeed that the data structure is allocated with
> devm_kzalloc(), which as Greg points out must not be devm_ allocated
> (because its lifetime does not match the lifetime of devm_ allocated
> memory).

Thanks a lot for the detailed explanation.
Crystal clear for me now.

Do you want me to send a patch to remove the devm_ or will you?

CJ

> 
>> I've been working on understanding device managed memory recently for
>> Smatch.? It's really complicated.? There are a bunch of rules/heuristics
>> that I'm slowly creating to generate new warnings but I'm a long way
>> from understanding it well myself.
>>
> 
> A data structure embedding struct device must not be devm_ allocated,
> and it must be released with the release callback. Maybe there is
> a means to flag that somehow ?
> 
> Guenter
> 


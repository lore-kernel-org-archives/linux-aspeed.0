From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 7 Apr 2021 11:56:04 -0500
Subject: [PATCH v4 1/4] dt-bindings: serial: 8250: deprecate
 aspeed,sirq-polarity-sense
In-Reply-To: <YG3NR4bGRjIGZhgx@kroah.com>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
 <20210402182724.20848-2-zev@bewilderbeest.net>
 <YG3NR4bGRjIGZhgx@kroah.com>
Message-ID: <YG3kJC+6gLC6RzzQ@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 07, 2021 at 10:18:31AM CDT, Greg Kroah-Hartman wrote:
>On Fri, Apr 02, 2021 at 01:27:21PM -0500, Zev Weiss wrote:
>> This property ties SIRQ polarity to SCU register bits that don't
>> necessarily have any direct relationship to it; the only use of it
>> was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.
>
>Please write that as:
>	c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq polarity")
>

Ack, will do.

>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>
>What changed from previous versions?  That always goes below the ---
>line.
>

I included an overview of that in the cover letter 
(https://lore.kernel.org/openbmc/20210402182724.20848-1-zev at bewilderbeest.net/); 
is it desirable to also have that duplicated in the individual patches 
in the series?


Zev
Zev


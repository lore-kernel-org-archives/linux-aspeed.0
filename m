From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 31 May 2022 11:06:12 +0200
Subject: [PATCH 1/2] net/ncsi: use proper "mellanox" DT vendor prefix
In-Reply-To: <48cb78ebd38dfe4ac05e337d5fb38623b7ee0e8f.camel@redhat.com>
References: <20220529111017.181766-1-krzysztof.kozlowski@linaro.org>
 <48cb78ebd38dfe4ac05e337d5fb38623b7ee0e8f.camel@redhat.com>
Message-ID: <ae36420f-847b-c53b-24ad-22e3181bff51@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 31/05/2022 10:21, Paolo Abeni wrote:
> Hello,
> 
> On Sun, 2022-05-29 at 13:10 +0200, Krzysztof Kozlowski wrote:
>> "mlx" Devicetree vendor prefix is not documented and instead "mellanox"
>> should be used.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  net/ncsi/ncsi-manage.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
>> index 78814417d753..80713febfac6 100644
>> --- a/net/ncsi/ncsi-manage.c
>> +++ b/net/ncsi/ncsi-manage.c
>> @@ -1803,7 +1803,8 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
>>  	pdev = to_platform_device(dev->dev.parent);
>>  	if (pdev) {
>>  		np = pdev->dev.of_node;
>> -		if (np && of_get_property(np, "mlx,multi-host", NULL))
>> +		if (np && (of_get_property(np, "mellanox,multi-host", NULL) ||
>> +			   of_get_property(np, "mlx,multi-host", NULL)))
>>  			ndp->mlx_multi_host = true;
>>  	}
>>
> 
> I can't guess which tree are you targeting, devicetree? net-next? could
> you please specify?

Both independently. The patch here for net-next (although it is closed
now). The DTS patch can come later via ARM SoC maintainer tree.


Best regards,
Krzysztof

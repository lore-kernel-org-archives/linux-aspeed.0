Return-Path: <linux-aspeed+bounces-2860-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83067CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 15:46:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4vCb6xKrz2xqj;
	Tue, 11 Nov 2025 02:46:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762789579;
	cv=none; b=axhd3LT/rmoMBb6NZfZc8pPOa8s6+XbYOnZ+66gJH+R5v/gN0Dy1eGPqRw2DSG0k4EnHae8GEXLGqIeBHUkWbE+ZcQrft8MJ/S70X5KC6jbPQOfUXGmklQM/28tH1wFMuvhYYq4Sxs7uZ7x8NjEcfgDoM9CvlJxmlfDIPB9B1rd18rBEqTdZ7EKbvU/UzVjpxWjKmZT2YHPxsshNyMAcR+gPl9AKQW5Miv7nT3S5mQx8OaUZHHxahesPQhdfSrqSulVNqbzvgyrrwzMGWeBaBk63Ke9Bbdl8CuiyNpFqcSVLHgCtwxEHOFHJ+S6GNBm/GRdqZo5qMyyeDkZXnBbmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762789579; c=relaxed/relaxed;
	bh=8nZLD9diL5Nl54JqOLMmgecUuCsULo/6MkV2RzeMUYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSnNOpJcRg7RmFE9XJ1XVSn1+jdfzAL+GTZZD9FVKEQ41EAB83ysfLBoPvtH2oyNqisHMBlCPQ5bS35L1tFy7PJj91gq/SV1bbEZysiKfhDVBVxvEwD1YBq6W01yAMUjiaE75zrZ2hWsdtfvi+2T+zfgHgqPnUK5x202udX6CNjGaTKDxjyEhvLrfoYU9jyJVJpQ8te6LY7ByjJUd9JoMAi+w1l4VAle4ds3T/IJmxR2o++fhtfM3ZwBGCNOnhbRpSFz2MEmN+89i/rRxVj6UHG00IDwJZ6/0A3TI3ZvuLtPiKCm9439lVg6kAYIkjNoYgWhjKRwgLMVBwWtJyPL9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=F7VuTdwM; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=F7VuTdwM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4vCb2VCdz2xqh
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Nov 2025 02:46:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8nZLD9diL5Nl54JqOLMmgecUuCsULo/6MkV2RzeMUYA=; b=F7VuTdwMDensrQoEHPLpu3zbJi
	62AkImrh5wvQK3G572aiWMaUpJbB2vNNXs6TxVhfz1pVQ8gU+8Cycs3KCY9PGuIeYiScScJj4Q77/
	H4/1yTstNex7J7LSb+gGbvhqamTNVcVqL4NDtUE9IovP4a5Cwwq9+hYQzPG9RDHvewmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIU5e-00DXER-4n; Mon, 10 Nov 2025 16:45:58 +0100
Date: Mon, 10 Nov 2025 16:45:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <8c6e1286-782a-44c5-ac9b-21d1db177d6e@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>

On Mon, Nov 10, 2025 at 07:09:28PM +0800, Jacky Chou wrote:
> On the AST2600 platform, the RGMII delay is controlled via the
> SCU registers. The delay chain configuration differs between MAC0/1
> and MAC2/3, even though all four MACs use a 32-stage delay chain.
> +------+----------+-----------+-------------+-------------+
> |      |Delay Unit|Delay Stage|TX Edge Stage|RX Edge Stage|
> +------+----------+-----------+-------------+-------------+
> |MAC0/1|     45 ps|        32 |           0 |           0 |
> +------+----------+-----------+-------------+-------------+
> |MAC2/3|    250 ps|        32 |           0 |          26 |
> +------+----------+-----------+-------------+-------------+
> For MAC2/3, the "no delay" condition starts from stage 26.
> Setting the RX delay stage to 26 means that no additional RX
> delay is applied.
> Here lists the RX delay setting of MAC2/3 below.
> 26 -> 0   ns, 27 -> 0.25 ns, ... , 31 -> 1.25 ns,
> 0  -> 1.5 ns, 1  -> 1.75 ns, ... , 25 -> 7.75 ns
> 
> Therefore, we calculate the delay stage from the
> rx-internal-delay-ps of MAC2/3 to add 26. If the stage is equel
> to or bigger than 32, the delay stage will be mask 0x1f to get
> the correct setting.
> The delay chain is like a ring for configuration.
> Example for the rx-internal-delay-ps of MAC2/3 is 2000 ps,
> we will get the delay stage is 2.
> 
> Strating to this patch, driver will remind the legacy dts to update the
> "phy-mode" to "rgmii-id, and add the corresponding rgmii delay with
> "rx-internal-delay-id" and "tx-internal-delay-id".
> If lack these properties, driver will configure the default rgmii delay,
> that means driver will disable the TX and RX delay in MAC side.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 148 +++++++++++++++++++++++++++++++
>  drivers/net/ethernet/faraday/ftgmac100.h |  20 +++++
>  2 files changed, 168 insertions(+)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index a863f7841210..5cecdd4583f6 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
> +					     u32 rgmii_tx_delay,
> +					     u32 rgmii_rx_delay)
> +{
> +	struct device *dev = priv->dev;
> +	struct device_node *np;
> +	u32 rgmii_delay_unit;
> +	u32 rx_delay_index;
> +	u32 tx_delay_index;
> +	struct regmap *scu;
> +	int dly_mask;
> +	int dly_reg;
> +	int mac_id;
> +	int ret;
> +
> +	np = dev->of_node;
> +
> +	/* Add a warning to notify the existed dts based on AST2600. It is
> +	 * recommended to update the dts to add the rx/tx-internal-delay-ps to
> +	 * specify the RGMII delay and we recommend using the "rgmii-id" for
> +	 * phy-mode property to tell the PHY enables TX/RX internal delay and
> +	 * add the corresponding rx/tx-internal-delay-ps properties.
> +	 */
> +	if (priv->netdev->phydev->interface != PHY_INTERFACE_MODE_RGMII_ID)
> +		dev_warn(dev, "Update the phy-mode to 'rgmii-id'.\n");
> +
> +	scu = syscon_regmap_lookup_by_phandle(np, "aspeed,scu");
> +	if (IS_ERR(scu)) {
> +		dev_err(dev, "failed to get aspeed,scu");
> +		return PTR_ERR(scu);
> +	}

You are adding the scu to the dtsi.

> +
> +	ret = of_property_read_u32(np, "aspeed,rgmii-delay-ps",
> +				   &rgmii_delay_unit);
> +	if (ret) {
> +		dev_err(dev, "failed to get aspeed,rgmii-delay-ps value\n");
> +		return -EINVAL;
> +	}

This is probably going away, replaced by hard coded values.

> +	tx_delay_index = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
> +	if (tx_delay_index >= 32) {
> +		dev_err(dev, "The %u ps of TX delay is out of range\n",
> +			rgmii_tx_delay);
> +		return -EINVAL;
> +	}
> +
> +	rx_delay_index = DIV_ROUND_CLOSEST(rgmii_rx_delay, rgmii_delay_unit);
> +	if (rx_delay_index >= 32) {
> +		dev_err(dev, "The %u ps of RX delay is out of range\n",
> +			rgmii_rx_delay);
> +		return -EINVAL;
> +	}

> +	regmap_update_bits(scu, dly_reg, dly_mask, tx_delay_index | rx_delay_index);

How does backwards compatibility work? rgmii_rx_delay and
rgmii_tx_delay default to zero? So by default, todays working DT blobs
will have 'rgmii', so end up turning off delays here. And then they
pass _RGMII to the PHY, and have no delays. And networking is broken.

I think you actually need to be reading the current SCU settings and
then deciding if you want to override it or not.

I suggest you change the order of the patches in this series. Move
this patch before you update your RDK .dts file. That way, you get to
test both an old and new blob.

	Andrew


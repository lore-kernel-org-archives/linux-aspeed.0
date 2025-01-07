Return-Path: <linux-aspeed+bounces-345-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A664EE77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 23:13:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSRg027x7z30TF;
	Wed,  8 Jan 2025 10:13:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736291596;
	cv=none; b=BoMX1dIF1bF6lPsym4M/3f9rw8T5IU5tEiHaxblkRJweyKjWslgUgu3qcR9GQxE56f0LbsBGmN0k/worM/iqwM5eexvsNMr8EB17TX0qw+CAUydTLT7BEYVprMaXuclLADUJWey1BTYAbG73m0h9ddA1g0J1XNEGtDaEmaePbAkuQ2sJMDUmt1X9SWjZaHhg0p2PV2RW0wEcehVp5l/2eCO2WiNnFSnFzoikMCQVPmdRhvitk225aq39vMECva7sgKxnVcK3jBEXTBND5gqY9baRie5xbfqkoaKlwpmSknN7nf0s5tS5wopy2sHbKZw8GSn6V9sU0zZ07DBfMmap2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736291596; c=relaxed/relaxed;
	bh=cXWjOzH5UzEYw27TDmJ11UEwxNrIrh3j6oaKp86+zmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSBULOyq/onA2PKsRSf3xaeBDG6pmhYAZ9jhvJ2Px9JYb4jG/QiJEC9uzRUiLHF2hfynGacyHqj+VZpgz4kIir1YWILU0Zjy5l1ZKNE9139gLIhur63vBknoGSny1fhzMq86PXds1X9FKo+q9moEzGm6VlO/8zq1BbZxB4Y5n3iVzO29AxYZeFU2dzT1drYrJEedfVARdAN/f0lc9PPRP8yzwt28CAm6QTygLJL74XAEQsBJ294zQDBQS3EoWCuzl8COqD4Q9BLZ2JiHn3jg61uC8/lJlDScm23wqm8FcN4z+hL4OfTnbkbhJgc8lHhboYldi+EvEVYH0Kj/8XRkWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BpvIv3gv; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BpvIv3gv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSRfz1hYSz304f
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 10:13:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ED71A5C0F91;
	Tue,  7 Jan 2025 23:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A1DC4CED6;
	Tue,  7 Jan 2025 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736291592;
	bh=Do/168fsFw6i80h2fR3YzMw5FE9OseaEDLt7XS3HU7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpvIv3gvmHkpEVhnNyN37lX3TxNiebJs1tHfvBdm0G1eeX0t4GC7nnRsRoB+jCF6U
	 8YjvgIye0yGn1ndJ+hDTT+RnJJZeNboOru3+3jHg7A+ierFyLCkCzgdRfjyqnuLdkX
	 drGMJ0FHxB/3GWIWzQ4Moj3LGfdg1JXVilAeJHIGjnEEhWDRP60H43Wt2wWWIrQLSs
	 BRuiPpRBy94Hn0tW6weXnf54+bcu5BfzwXLgzLaj49cvvyGvqAth642gSMS+JejS+j
	 hj4OdFu47n9KCunxQjIogQnds/pm1TmtgIL/6imDVnrlJ6cDzanK7j8Han8EJAU2NC
	 RIpHEzG19CDZw==
Date: Tue, 7 Jan 2025 17:13:11 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] bindings: ipmi: Add binding for IPMB device intf
Message-ID: <20250107231311.GA1965288-robh@kernel.org>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
 <20250107162350.1281165-3-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107162350.1281165-3-ninad@linux.ibm.com>

On Tue, Jan 07, 2025 at 10:23:39AM -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface driver.

Please mention this is already is already in use both in a driver and 
.dts files.

> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> new file mode 100644
> index 000000000000..9136ac8004dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IPMB Device Driver

Bindings are for devices, not drivers. Drop 'Driver'. It's a stretch 
that IPMB is even a device, but since there are already a few users, I 
guess we're stuck with it.

> +
> +description: IPMB Device Driver bindings

No point in a description that just repeats the title. Please expand 
this. For example, AIUI, this is for the device end, not the BMC end.

> +
> +maintainers:
> +  - Ninad Palsule <ninad@linux.ibm.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ipmb-dev
> +
> +  reg:
> +    maxItems: 1

As this is the slave end, I2C_OWN_SLAVE_ADDRESS should be set. So:

minimum: 0x40000000
maximum: 0x4000007f

Maybe 10-bit addressing has to be supported too?

> +
> +  i2c-protocol:
> +    description:
> +      This property specifies that the I2C block transfer should be performed
> +      instead of SMBUS block transfer.

This can be more concisely said:

Use I2C block transfer instead of SMBUS block transfer.

> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        i2c@10 {

'i2c' node name is for i2c buses and this is not one. 'ipmb' is probably 
fine here.

> +            compatible = "ipmb-dev";
> +            reg = <0x10>;
> +            i2c-protocol;
> +        };
> +    };
> -- 
> 2.43.0
> 


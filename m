Return-Path: <linux-aspeed+bounces-2200-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C0BCA101F
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Sep 2025 23:41:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMcdh56wyz2xnh;
	Thu, 11 Sep 2025 09:41:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757513672;
	cv=none; b=MqXyCNX9GZRsfGLWgSGLfvoryS+oKzOu67GJEBUsOSUvwvy8WMj1xP5wiZ287aVMyCv6ekLu8PEIASZlx8mHDgkJ7x2cKPj88sAD09xYqkQ2pLDQ3GykScJBB/Ah0hGBAv5mbDIoUrphUzN51sd62YF1jrRVv64z2O6YwzemtfPd2VUBEjFQsY23gdwptmBx0r7qFO4jeMOCyL0Upplyoy/ntp3huaWbrmxxEdCWXEAFH+oDiDbW+BhmD0mgiv9LSWIA913BQWZL96AOcKcP2qdlOGeOi76fiQc8AFope48w51Yf+B2bw1T2fqPhM8fUrm01I9KMpXdICxEB1a8SlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757513672; c=relaxed/relaxed;
	bh=4AKBrsHYyZy6NVWerxVC8iAlV9/6fvAVIrP6ESd120U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MBnOSr202cfrGoTDB5Fwd9Os6bCn0tahVC3xky/ni4Hasxw5DBNDER/9nAsoIoNhPXAcVh+XohobFVd7SNbLgJhj4RHwWO72lIR7RjshjXOSk4ZroZmWBrY5Zh1i4/4VOdepp9tcxEvqGL2S28UUdvMLRk6MXz6rlYqzbAzvL8zcFGCvSKcM89KGEd3HHi1HQThss4amUBglGPiCRGTWo1wMX1ZEaogde97gyPHHF3hxwMY6GyC+8Cnb1KT8pabXF0YpycTbNqaOXJpPRmShK7aovdIvfsCoCvQvVS8ajdVnCuhh4AfHPq2cHiKHXqKVFnycV9rS1/uYLF4pnLkh4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTxWaaHT; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTxWaaHT; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTxWaaHT;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTxWaaHT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMN3q5GkFz3dCH
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Sep 2025 00:14:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757513667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AKBrsHYyZy6NVWerxVC8iAlV9/6fvAVIrP6ESd120U=;
	b=BTxWaaHTtOtGwDywzanXaVXZxJdaVxryrkLrnQ4nhGLAgnTTwY3Q9tNVf3ENMSRMrSTIZ0
	bSR3yWws/GO+q7PDyXpBN4UNskvGRVV3vsPhIgcPJ4fcM9EQeHzdOfOxqhTphP01qIz+78
	K8MmIXLWbpmTIuOnQbY0Q0ku5vJONMA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757513667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AKBrsHYyZy6NVWerxVC8iAlV9/6fvAVIrP6ESd120U=;
	b=BTxWaaHTtOtGwDywzanXaVXZxJdaVxryrkLrnQ4nhGLAgnTTwY3Q9tNVf3ENMSRMrSTIZ0
	bSR3yWws/GO+q7PDyXpBN4UNskvGRVV3vsPhIgcPJ4fcM9EQeHzdOfOxqhTphP01qIz+78
	K8MmIXLWbpmTIuOnQbY0Q0ku5vJONMA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-QLHVcThxOeuw2-3jE7umLw-1; Wed, 10 Sep 2025 10:14:25 -0400
X-MC-Unique: QLHVcThxOeuw2-3jE7umLw-1
X-Mimecast-MFC-AGG-ID: QLHVcThxOeuw2-3jE7umLw_1757513665
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7ffb4a65951so2748155385a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Sep 2025 07:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513665; x=1758118465;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AKBrsHYyZy6NVWerxVC8iAlV9/6fvAVIrP6ESd120U=;
        b=qLydTdx/ocrVuh4+xIJ/JdNDdrLeOvGT1T3Ej5/uaoRNqpaeUecirTwl923b+qrZov
         QMCtfTZUeGfNghk4q8B5K7U9qk8vafV6V1VY1A+UBfBHNXA+SRxMJb3teiEGC+8J45r6
         fc2AR4zXwVrvMHXIs7FyhUwZLFzN2f3SSQZtdR7CRTs3oO03/NfOmZEmLYmw5+5tHKRm
         jc9TbdzsZBfg2PTdO2NZmfNHhxXFrYxpkcHpGq5u+9PHDFv4nILqVyKG6LX4Ad5Vl/oJ
         tfvqqxNpkTwIdw9L9UHN8pyIN0bRof+i+TCkpki50a1B+jXERhaMXzoSVX+juUBApaB8
         ZU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5d3ozlX5KT3J9NljAJHbIG9iWbkytP2MstHaO6MwBk7Hzj4caWBq8F25dMjZlae0+rvrcrQ4bxsRjpX0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxPJDjl0n1mLxh7KqeuOSsIImi7hhnK3Wg4aMgxch5BHwGfDnLe
	OPqw++g2ulCHAb5bDHGk9ZwGgYblHuzOwKYtjQr1RdBVBdIygW1QVbgAC8mKJkEI0f8gkbb5M4e
	DHhRILb6Aj6a+2hOXiKzRvoNPuVBVNoaKbEh0Aoka1RgedqWxZ0HJRgKDwVnghfJVl5Y=
X-Gm-Gg: ASbGncu+pTcfBsMHxW/SMOB4p8Om2xo6lVIg+gYQ3RH421b1UiAemqqK77FgqKcUUyf
	+BPEY9XGRkifqCAbBFf5VAFeDQvklS/4hsw9Eoe8DDY3BwqLNdMq2X+jJlAuAIEEhZVSHhNE24l
	ajfyPBM7miWCFeXO7xAo8SInhPAUutYkn9/Wf0Ks+8MYqHVMLWQgj1anvJD1Pa/yKDza8E3L6v1
	RY91M5Un5ulyD1YUejAjJLNcthB4rp33z+e9jK4bX3GJ1K2sm+5Sx6uqbirzexv6w5PFcHfBcDh
	z4fYcQK01AGZBx2KT6gPiUXtDEEtiYRoUhNmQEeJUOlHO+KcGnB4dUPdSJix677nQY67n7gMaMU
	9VJjvmseP22NVSzFnBxw=
X-Received: by 2002:a05:620a:1997:b0:7e8:922:f02b with SMTP id af79cd13be357-813bed042c0mr1615331885a.25.1757513664998;
        Wed, 10 Sep 2025 07:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkFeL3wPJOKIe3shUG9pzAQKQjdBD+pGyVy/83wrA05r4tPdXbaw2hUPMEXQ3KZIEvXGTTLQ==
X-Received: by 2002:a05:620a:1997:b0:7e8:922:f02b with SMTP id af79cd13be357-813bed042c0mr1615324385a.25.1757513664239;
        Wed, 10 Sep 2025 07:14:24 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58b5d7fesm299937185a.8.2025.09.10.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:14:23 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:14:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mo Elbadry <elbadrym@google.com>,
	Rom Lemarchand <romlem@google.com>,
	William Kennington <wak@google.com>,
	Yuxiao Zhang <yuxiaozhang@google.com>, wthai@nvidia.com,
	leohu@nvidia.com, dkodihalli@nvidia.com, spuranik@nvidia.com
Subject: Re: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <aMGHvHf6BPrJD1pC@x1>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
 <20250708052909.4145983-4-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250708052909.4145983-4-ryan_chen@aspeedtech.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j09uUXqgiZHMJ-G20jr4tz7EjzHmpky4TkGA9SLWUO4_1757513665
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ryan,

On Tue, Jul 08, 2025 at 01:29:09PM +0800, Ryan Chen wrote:
> Add AST2700 clock controller driver and also use axiliary
> device framework register the reset controller driver.
> Due to clock and reset using the same register region.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

I just have a few very minor style comments below. Otherwise the driver
looks good to me.

> +static struct clk_hw *ast2700_clk_hw_register_hpll(void __iomem *reg,
> +						   const char *name, const char *parent_name,
> +						   struct ast2700_clk_ctrl *clk_ctrl)
> +{
> +	unsigned int mult, div;
> +	u32 val;
> +
> +	val = readl(clk_ctrl->base + SCU0_HWSTRAP1);
> +	if ((readl(clk_ctrl->base) & REVISION_ID) && (val & BIT(3))) {
> +		switch ((val & GENMASK(4, 2)) >> 2) {
> +		case 2:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1800 * HZ_PER_MHZ);
> +		case 3:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1700 * HZ_PER_MHZ);
> +		case 6:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1200 * HZ_PER_MHZ);
> +		case 7:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 800 * HZ_PER_MHZ);
> +		default:
> +			return ERR_PTR(-EINVAL);
> +		}
> +	} else if ((val & GENMASK(3, 2)) != 0) {
> +		switch ((val & GENMASK(3, 2)) >> 2) {
> +		case 1:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1900 * HZ_PER_MHZ);
> +		case 2:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1800 * HZ_PER_MHZ);
> +		case 3:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> +							       0, 1700 * HZ_PER_MHZ);
> +		default:
> +			return ERR_PTR(-EINVAL);
> +		}
> +	} else {
> +		val = readl(reg);
> +
> +		if (val & BIT(24)) {
> +			/* Pass through mode */
> +			mult = 1;
> +			div = 1;
> +		} else {
> +			u32 m = val & 0x1fff;
> +			u32 n = (val >> 13) & 0x3f;
> +			u32 p = (val >> 19) & 0xf;
> +
> +			mult = (m + 1) / (2 * (n + 1));
> +			div = (p + 1);

The ( ) is unnecessary here.

> +		}
> +	}
> +
> +	return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, name, parent_name, 0, mult, div);
> +}
> +
> +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void __iomem *reg,
> +						  const char *name, const char *parent_name,
> +						  struct ast2700_clk_ctrl *clk_ctrl)
> +{
> +	int scu = clk_ctrl->clk_data->scu;
> +	unsigned int mult, div;
> +	u32 val = readl(reg);
> +
> +	if (val & BIT(24)) {
> +		/* Pass through mode */
> +		mult = 1;
> +		div = 1;
> +	} else {
> +		u32 m = val & 0x1fff;
> +		u32 n = (val >> 13) & 0x3f;
> +		u32 p = (val >> 19) & 0xf;
> +
> +		if (scu) {
> +			mult = (m + 1) / (n + 1);
> +			div = (p + 1);
> +		} else {
> +			if (clk_idx == SCU0_CLK_MPLL) {
> +				mult = m / (n + 1);
> +				div = (p + 1);
> +			} else {
> +				mult = (m + 1) / (2 * (n + 1));
> +				div = (p + 1);

The ( ) is unnecessary on div on the three places above.

> +static void ast2700_soc1_configure_i3c_clk(struct ast2700_clk_ctrl *clk_ctrl)
> +{
> +	if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID)
> +		/* I3C 250MHz = HPLL/4 */
> +		writel((readl(clk_ctrl->base + SCU1_CLK_SEL2) &
> +			~SCU1_CLK_I3C_DIV_MASK) |
> +			       FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,
> +					  SCU1_CLK_I3C_DIV(4)),
> +		       clk_ctrl->base + SCU1_CLK_SEL2);

This block is hard to read. What do you think about this instead?

        if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID) {
        	u32 val;

                /* I3C 250MHz = HPLL/4 */
                val = readl(clk_ctrl->base + SCU1_CLK_SEL2) & ~SCU1_CLK_I3C_DIV_MASK;
                val |= FIELD_PREP(SCU1_CLK_I3C_DIV_MASK, SCU1_CLK_I3C_DIV(4));
                writel(val, clk_ctrl->base + SCU1_CLK_SEL2);
        }

With those addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>



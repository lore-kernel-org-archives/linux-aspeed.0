Return-Path: <linux-aspeed+bounces-468-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0F6E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 16:46:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXZlB0lJWz30hG;
	Wed, 15 Jan 2025 03:46:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736873174;
	cv=none; b=c/QjMzUD5LY0BJ3cB1IwbkFLp+gtQmobmAR3/i2sLeg1ggwu3S8LNM8QY6wUHkQ0iE173yWc0UORlGiQDKTpaJMze2nG/GpcBQpwZRNAgo6XfzLXr/Wm4+CuTWv0IhbLfOoMrJleAOQcs/3T7DIZsM8MqGo9AXDCs5xzk4yC9D0hLQkawaz8cDbVs0THS4OdW1wRSyZoNK+hzAfxA7qUyFHPMjCd98Dq4ILnRc6KbwmL7Di2kmHJqmdjYeXKi+K5yLpzfW0Vlp2jzDfDVucZm+UdM6XbSpmngYI5TcoPxaAYREmstO+DssMm9Ki8VBGSYYIM6FdTyd9Yy0SFuYJUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736873174; c=relaxed/relaxed;
	bh=RxWYotfxywN3NwGBQO3BiIkoRPcGTpIVsh2/TXME74Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgPa394zLnMAhPrmsOM1kR25ieQaeIYWAkjpd5K1WxLQqD5yRAiGoYatzq8ky1ZRha1ebQnZMhP6O0XeE4L6gXoZeioQAJzxUokSdrHJibhwLa2GDQXalyg3HB+gj04QeRXv4UM07TTfSNYygHGneDtgMT5IcIw/XZNG8hVTF0PktN+3N7SVkr7vvUvsz2mKnlIHG8Lmz7niCmU5HfsxPaDl2FsmFezo75cAq30joombFhYN+L+TxzolzTSU0SGFjKFdKR4etTWy6hhl9N1JP7car+rDR9s8ba5Nze0wwGEvyBW91DoSir8Pm3fgQEotREOreVxNkeBmlPMAzdX3Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net; dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HJpwCmtx; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org) smtp.mailfrom=minyard.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HJpwCmtx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=minyard.net (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXZl82BQdz30f5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 03:46:12 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2166022c5caso90055715ad.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 08:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1736873169; x=1737477969; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxWYotfxywN3NwGBQO3BiIkoRPcGTpIVsh2/TXME74Q=;
        b=HJpwCmtxu20MhQ6ZX1mMXYeDlRFWRex7OPhBdFlmLraa9tLYEMRjRfiCOInveDyXAK
         Z7eUs3YPnsJaXVOK1Y/jFAvKnBniwQcRNR65WlzkFTfqWY3ieQb4nIkgUKdOAZM2KkgT
         guMU9GEdCIhsZzHhivpbWGOo5GEG4SEvHGU28twPEuTFfTNCigWsTesTNDewjgvz2GGT
         f2mnRtyTratxP5hNht4adxGcm0HRfsgqTGCC4O+eKnfRU70FofzWDqENjkfRwIZxm+qt
         6lrXqiZ+6c6nN7oExb+d5w//Nga5rxogwCRINlPxpnoe38AcdIeQt8mPtOcF6j3AB2TM
         hz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873169; x=1737477969;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxWYotfxywN3NwGBQO3BiIkoRPcGTpIVsh2/TXME74Q=;
        b=sy0JTkhaAF5qtcZHESzvOKR21SCvbe3/mZ61jQXcyY15TB6juFmYLGciRPSxMHdBjj
         DUXSkLVxlukWHdZ+ny36I7SAQSJjNkbpbpBPNBVUyOoBoBNEnYofJz3aj4kRazNlrd/M
         iYbY8qn8LRYyIPwBpaDi2Mhv4wz8dLeL/+ggQAxojaCFhCjzGBECerPftju84hLRTR4n
         9ddhSmdrwcbZxUmuwY7ajZIdaVcyyne15m/gjr4/raWicj3L7HBAbGTimmskugc/3vev
         bqiw4xtsaVPNI6ISda+IY8lvtZkNoBh8r/FqDkMYY79a2hIZp8JOh7zWgC5qNcDJf5GC
         OTNg==
X-Forwarded-Encrypted: i=1; AJvYcCW1LvbF5d6Z3utzTYbgFPYEftW6xGvEwMw2gTevwXfq6SNESlWh4G+l+DkIeshz+GuahNUKiR2ZDdRLvWk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzAAiMNgpWwmXk/HDUf1kQ4XbEMlzsJxauJcRrFkw1nPzBfmi0x
	X2jJHh63SoFrAJP+c1bleWhmMmO0w+3nB5Eg9AHopv9muFMQa7fNMybA4fXfgy0=
X-Gm-Gg: ASbGnctEWG6ZW1aNH0SXosYRjNlJBqm8aQt7Ks951Ng9WJjxf98SPQbzkUbnt9i9aVf
	esPZQ2imeBB9edGsC3Bcrj2XlKGYE15sMdzKV8V2AbDzHESkq1H5ZWRhArkwBg2k0GHEftI9slq
	t9bCT/z8Fseq3SwyrYbczpScB5tE5wmWY0Ny+WUarirE5dbVlwzS4YLOBzjsKvNrqIm2uRkhFuh
	BPmd1rC25ecqlFe6kpETQaa2klTAwcQVM0TFqPwXL7BaqflHFHyCdXp0V6P
X-Google-Smtp-Source: AGHT+IFduq35RcsU3aO5RRhPDalwAW/p83/zhfkLttMULeNifRcViC7DtwI7vuIYT8rQlSliD0flaA==
X-Received: by 2002:aa7:8887:0:b0:72a:bb83:7804 with SMTP id d2e1a72fcca58-72d21fd2e16mr34122515b3a.17.1736873169522;
        Tue, 14 Jan 2025 08:46:09 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:4641:6dae:60a7:e5ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065a560sm7614353b3a.87.2025.01.14.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:46:08 -0800 (PST)
Date: Tue, 14 Jan 2025 10:46:01 -0600
From: Corey Minyard <corey@minyard.net>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] bindings: ipmi: Add binding for IPMB device intf
Message-ID: <Z4aUyX8g-JprzLpd@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250113194822.571884-1-ninad@linux.ibm.com>
 <20250113194822.571884-3-ninad@linux.ibm.com>
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
In-Reply-To: <20250113194822.571884-3-ninad@linux.ibm.com>

On Mon, Jan 13, 2025 at 01:48:12PM -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> new file mode 100644
> index 000000000000..136806cba632
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: The Intelligent Platform Management Bus(IPMB) Device
> +
> +description: |
> +  The IPMB is an I2C bus which provides interconnection between Baseboard

"Baseboard -> "a Baseboard"

> +  Management Controller(BMC) and chassis electronics. The BMC sends IPMI
> +  requests to intelligent controllers like Satellite Management Controller(MC)
> +  device via IPMB and the device sends a response back to the BMC.

device -> devices
"a response" -> responses

> +  This device binds backend Satelite MC which is a I2C slave device with the BMC

You use IPMB devices on both the BMC and the MCs.  The sentence above is
a little confusing, too.  How about:

This device uses an I2C slave device to send and receive IPMB messages,
either on a BMC or other MC.

> +  for management purpose. A miscalleneous device provices a user space program

Misspelling: miscellaneous

> +  to communicate with kernel and backend device. Some IPMB devices only support

"kernel" -> "the kernel"

> +  I2C protocol instead of SMB protocol.

the I2C protocol and not the SMB protocol.

Yes, the English language uses way too many articles...

That is a lot of detail, but it looks good beyond what I've commented
on.

> +
> +  IPMB communications protocol Specification V1.0
> +  https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmp-spec-v1.0.pdf
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
> +
> +  i2c-protocol:
> +    description:
> +      Use I2C block transfer instead of SMBUS block transfer.
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
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ipmb-dev@10 {
> +            compatible = "ipmb-dev";
> +            reg = <0x10>;

I'm not sure of the conventions around device tree here, but the reg is
not used in the driver and it will always be the I2C address that
already in that node just one level up.  It does not serve any purpose
that I can see.  My suggestion would be to remove it.

-corey

> +            i2c-protocol;
> +        };
> +    };
> -- 
> 2.43.0
> 


Return-Path: <linux-aspeed+bounces-2428-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F47ACCD185
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 00:21:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clvyW5q8yz2yrF;
	Tue, 14 Oct 2025 11:21:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760401267;
	cv=none; b=Gxyaj9i0pSWHDnsrhGPP0kS+jdFe5uNnHD7cxg5DoGw/KT7j08ErZ2h6cdQshvY4fU7CAFZfclRQwCjiIyzgHwYwBnTxAGZZUgqdKz2jLyIx5KLEzmv56oTfpo9CLJGRbw9KHJ9bnBMQj6iJcA0Lb2reFOpaN7N3VD0YlsEDjJZaxAVa39Sd0pLUIyHgpZqFuboi4n8GRsx6DYTYdSDaFDz23qZFmNYWFyCMFL/cdT1aZnoL5BMkYpBJ76npC0Zox06FDZELGid0fm8PzcH4+K3oHQZoH3AlW9+HSQ6YQ1OWV4o9ModkGBA2PXMcYm+gwF5xUnJaY41Fv5Bh/NojOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760401267; c=relaxed/relaxed;
	bh=FapHoBZSBBgkeAPgfh0/hnIRZ5RySUGbBwY1QHLC79Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV2AG4inE7VyUgyecUFeJ4ABlngHc0RSghVct9JqG8FReEJ5q+QYXxD1Dj38AGvQpfng28UkZODxUcRTy3zUmGa0BlhtyrHQLZV2Rzf8kptV+U/p6XQwLPtialedkxyphtl4mgjPlUbYLwzO4RmpkliJvs+0PhD2NYKSpYwuAkWXt7oTGoilcTkKYlJGJEgADuY4ILIPckJMw384HNrQW/oM7uer4Nr81aa3ovD62wND514crV9lWU2a9/5dDp0ZZ0WcR6yWyxVSTJhZf71MTisjf3KDDy5ArD5f8lykz2fgixDyaxr7IhUoVNupGDuDSmH3IzO5ar8ZmJj6WhVTXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cvszFvQV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cvszFvQV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clvyP6n59z2yr9
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 11:21:01 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-b631b435d59so3012062a12.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Oct 2025 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760401259; x=1761006059; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FapHoBZSBBgkeAPgfh0/hnIRZ5RySUGbBwY1QHLC79Q=;
        b=cvszFvQVWlxLcYJF2SvOmLC6GC1zZ1KZAWhoTBotBkH6yOJGvAm16Y5ADfa8dR/8JD
         dCjTBP2f6aXnxY9u5v/gPSKFkkxRXQUz5jLgHG600y2q5TU0CePIFbRCGATafX4whc0c
         8t9JPV2KTCuGOf58p197QePJ+b4iNE3n0JiYuPbiJVTGrUbt9Fn7oQk7bM/0/4JoOmJK
         bNW181rKafuPeVMFGj4OOo/gTvFOfE7vxv61v33fKt+YPTYCSSqx9gPsxb/wrrQqutqT
         iaoF8Nf6kc4wkX9/s4rnk3oeR1Fc7HuWLt6wSPJ7eAI6gmKhu01hg/ZKFFgJpkqykrlO
         9DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760401259; x=1761006059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FapHoBZSBBgkeAPgfh0/hnIRZ5RySUGbBwY1QHLC79Q=;
        b=Wdi74CgnQ4YwmORGXBo/4f54MlI66JNfh4nZpsSphdiOw8nPu88w1c7C6UBP9kwFTt
         9EcEPuxfLdiNkePTZlvsh5mpMgX1P7snYRhlvGQVvzuLUXBVj769mMMlq+sKtccGcPCS
         DCCG5KzXwMgWrxZIx3AS6YJMzeKEUzKLv2ocMCkCrgSJnoPJoOTTHF+ha6Imb9mqSIvO
         UBn0zEsN/9AOkZK+hH5Zt7qJy0tH0o1Dzs52OyObi5qYWdWvJg4Z33k7yV1yP3y5TlXV
         FjA9amsEUo/bQrrhZsf2dowy/GPmn3kz3zLBapotUPSgM+1xIb+WbgxJ32QLfyRSbqsh
         ff8w==
X-Forwarded-Encrypted: i=1; AJvYcCXFIe8O0en+8qjauUXAPnQs7t/EDi2s2SIU4YScGfAN6ZV9RWTek8XOMT7kBK6qSnXBCZuD3uyhDrZjS5w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxM9uHRxsrGeDeOdVtRERnnwwtGIPkdpJNjO0wtLGU0h1lNte10
	LyfP+Y3YurNpI5LGVRGyFqaI7myIZRDJu7eIsRBzxYYZlslrN4zXRVAG
X-Gm-Gg: ASbGncv8rPRM2DULQJ2x7RkzqrLIQ4krc+3VDi5ZHiuOY6Jl9bvFAi+CJgRmODbKM5p
	Ag6kwxSm0hNQL6sPPPDXv0tK2NfjczW+i3PlDZpN/809jJ5OEsLi8YTx256xeG2jH979bxVfkHV
	C67GbN3oHA299tkVbky+XWZFHyt3cJXizTZusF+AY7eyPVJAjF5kTuUA1rZ4fRRoOfrizgY95N0
	+mkJIcYXDXtsqcqqT2YFbLR/YYJbpky0UeAgtGTxeeKlvfo0Za7CLsHa/mapLvFMlEk29Poywvk
	ri2LBp5fs7uqc55cdjR0qSWMREu62qsegeDGDbiK3lIHNzIkW+wTTYvUfFDtSirptsS+EmaW4IS
	jpQtgKeeMqf+3IBlfH9UCF+hflecHpUtLre4EnYT5Tru2LiFWwhgQzCmMHVYr3oAK
X-Google-Smtp-Source: AGHT+IF8IIF9dA+nUndexMgc/HlI7FOKBRCbLWHhmSyCq1fdJ7LM7JOtkUdL7gTzQp9WcaLBJmQIJw==
X-Received: by 2002:a17:903:8cc:b0:27d:69cc:990 with SMTP id d9443c01a7336-29027402f43mr305469345ad.49.1760401258830;
        Mon, 13 Oct 2025 17:20:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c7bsm145479255ad.3.2025.10.13.17.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 17:20:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Oct 2025 17:20:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: rentao.bupt@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
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
In-Reply-To: <20250728055618.61616-12-rentao.bupt@gmail.com>

Hi,

On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
> duplicated code.
> 
> Fuji-data64 and Fuji are identical except the BMC flash layout.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

With this patch in the mainline kernel, the Ethernet interface I use for
testing does not come online when loading fuji-bmc in qemu.

Reverting this patch fixes the problem.

Looking into this patch,

> -
> -#include <dt-bindings/leds/common.h>
> -#include "ast2600-facebook-netbmc-common.dtsi"
> +#include "aspeed-bmc-facebook-fuji-data64.dts"
>  
...
> -&mac3 {
> -	status = "okay";
> -	phy-mode = "rgmii";
> -	phy-handle = <&ethphy3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_rgmii4_default>;
> -};

I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
interface is now disabled. Adding it back in fixes the problem.
Also, MAC3 is explicitly enabled for fuji-bmc in qemu.

Was the interface disabled on purpose ?

Thanks,
Guenter


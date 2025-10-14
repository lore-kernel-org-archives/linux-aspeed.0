Return-Path: <linux-aspeed+bounces-2435-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948AACCD187
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 04:45:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cm1qr5fcyz2yrZ;
	Tue, 14 Oct 2025 15:45:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760417144;
	cv=none; b=oK87hbpJ1pKe+p9uUdAIjDyVN94yBzDU/T7zpS7v4J/FLTbObuDTl6tDoJ9oxtyTEDeG1rKREU5OYcdAYMaJ3N0Mz+DpqD2mY+ywaiCtjhzkpfj2HyOSnyVCwplAPFurcCnZYEYl/3PSnkNWF/6kdj8i7WzVaT+vTLBfKG4jybz6cvf6Zv5V6YAGaGrg9MdYhjpIYhNs8CKLBVZZnGiTf8gIW4d7ck8InxENkEBcD1gzy3ZuILdbBcfwINk9qUMAQ7JKCOdtoMQu8zwBkPBsMe7alNz+UiRot75In8UrGAyUI3nBKjmVeFsDemjuRWAA8Wzr/vM6z11ykBMQM3YKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760417144; c=relaxed/relaxed;
	bh=6IWAevNcHXjFvzpaRr8LOfdvjd37W/dKCFMhW8BIdjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av29qkbpB7N++lpwapdH1PzmSDqKqOBQKDc8J8wGl/aOphOeXSdNKvrqdhZPihFmzkB/NUAf2BXijM03lAQeIgvCuUHh1rOcXF8hhoBAL1Yuurq9vTG7Snd5aYJWBV8unAYAkPrgCpW7j9pAbjqTmSO180Hjo6bOnqpu4z7JDe1jUyU/Mt49h5+Qgh3i+NE4scCSTjC9lradJojVirnaOFBP2+j+8Wt4IK/DsSn7eejJzL28jvNm59Jm6rUAqumQ9kenNZ6jI3V6HSStaDYD6UrI9RzvFM8Kss1hiEfjLfQJ5GoTwapYbN0Qa6ydwPfujwJVPWuI0c3Vc92vmeVXJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hiJZ/4p8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hiJZ/4p8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cm1qq5vlyz2yr9
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 15:45:42 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so4359314a91.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Oct 2025 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760417141; x=1761021941; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6IWAevNcHXjFvzpaRr8LOfdvjd37W/dKCFMhW8BIdjo=;
        b=hiJZ/4p8t0huQTZ/wBLC+MFqGyL5BSAyivEcS63ofnSnLpZFTYikOvXJBaqOeDzdGe
         C1wx7TRqH3uH3XLs3BuThpIcbYCNmphn/98iS/W5XxuF5o0P9AkMGWGzHMkJk4tmt6Gx
         /LQA5ONod+HlddzN1BK5B6bSnzSZbtHhNpU1sAUnZpI7UCmHjg6zzv+5b9ZRK4gYp+Xp
         npvd0PWlRGpCURjLf0N6zudrm8OJoPVWzTHXo0k6nWp66wNu1RryFiCcFXLBRO8RR8k9
         Wd66XmNDWGa2KE6WMWfiuG/bVWdxI/jpJKhyDlkPRX9BGWkLTEG4rHWk04ZUBQzNughd
         Xw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760417141; x=1761021941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IWAevNcHXjFvzpaRr8LOfdvjd37W/dKCFMhW8BIdjo=;
        b=l7lYrSTR2caLpdWx+i2rfxb+pta0g9dnXlCM69Hl7nw8ehztookoRpu1kKwjc54svn
         b4ukZ1cHPZVI/25kuK1ezBunxyN74oz3HS0uwYO08ulCltTtISxaifjFLp/rbVsmXwjr
         Jn6D9vn9UAqxUfmaLFeyaTPeiYcf/5/qHlFPJAqW2fmuBuXy7ppZq216oZjVbRlQStG4
         NPRbCL4+nsWX3UShuWxwB0GOQKplcd4p3YyFDg4jpfJiOzK/vcjk443zbUxKnu9kznCv
         b3M+UHciLzX4259pwfnUzlpuOnoGAI7oCbWuLBHg129SUIMQygYSP+13Qm2FMpbwQo73
         4IUA==
X-Forwarded-Encrypted: i=1; AJvYcCWHey+3IGfCaM+6Mv4XSh5I2FU0mjfNgDO4Cuee4U98y4Qe3i1Jju0i5X8nNXl9qyjkTiE/K64fgt0E0xE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzaDWhwQ3anr4ePlJdVuESWuIGILEJ2Q1devYOR5R0teKFsXzwl
	XbdAZiKYyFpN/3LOPDMqcwSSor/jghDGhvxj4qAUjYmWPb8JU7cMOxUE
X-Gm-Gg: ASbGncsZw7IcPu4uASzg/E+N7Ayb6cW7Opo9U+TVhwfh2T8RLKunGEHth5SfD2i2OPJ
	07DSRbO2E/gfSExmUaaEB2zuB822Lw7/zLqV4bymZguxKu5SzGZ369SLoaG27MuSPPwerlGrVju
	RJUy03kmqUjO6xhW4xLAtGDyalIbkOFmF7kQ+obipWWQPNr4lhVbLwKN4N3i3XvywAHIMmPNcCh
	TD6lPw/KydaFczLUkmw9sYgrOiiz9mxxehKr88c7SmtE4dMThWHXdWETcSKiTUy5VkAkJ/OwniG
	au/CrhobOtbL0LcaVM07Io/Byqc8pfAV3cZaG4QFaELht+C6q4BL2IdM+2Pcw6HsGEE+GguTDNV
	u2PkdSGPQLSe+SWjd6J5eDW3CLBU3Xg2BOibv1f74GPq8ez8BloMrpXHbY8qP0Fr6KIug4vcgSQ
	==
X-Google-Smtp-Source: AGHT+IFpInrQ3BK2IUoEdZQ4XEmHh6tIaVzcz4A5h+n6G2cV7PgK4L9/NeRbvXUR10GkJ9cgViH1AA==
X-Received: by 2002:a17:90b:1b41:b0:32e:6019:5d19 with SMTP id 98e67ed59e1d1-33b513bdffdmr29320243a91.34.1760417141038;
        Mon, 13 Oct 2025 21:45:41 -0700 (PDT)
Received: from fedora (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d15e2sm14122596a91.21.2025.10.13.21.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:45:40 -0700 (PDT)
Date: Mon, 13 Oct 2025 21:45:38 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <aO3VcnvDgtYLLjoI@fedora>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
 <054cf209-61af-4d21-9a3b-d0f6dd24ee3b@roeck-us.net>
 <aO3M90Ycp2DWyFuk@fedora>
 <04dbdd20-69c1-48fe-9bc7-7e9ffaedbe9a@roeck-us.net>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04dbdd20-69c1-48fe-9bc7-7e9ffaedbe9a@roeck-us.net>

On Mon, Oct 13, 2025 at 09:35:43PM -0700, Guenter Roeck wrote:
> On 10/13/25 21:09, Tao Ren wrote:
> > Hi Guenter,
> > 
> > On Mon, Oct 13, 2025 at 08:44:17PM -0700, Guenter Roeck wrote:
> > > On 10/13/25 20:20, Guenter Roeck wrote:
> > > > On 10/13/25 18:15, Tao Ren wrote:
> > > > > Hi Guenter,
> > > > > 
> > > > > On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
> > > > > > > From: Tao Ren <rentao.bupt@gmail.com>
> > > > > > > 
> > > > > > > Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
> > > > > > > duplicated code.
> > > > > > > 
> > > > > > > Fuji-data64 and Fuji are identical except the BMC flash layout.
> > > > > > > 
> > > > > > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > > > > > 
> > > > > > With this patch in the mainline kernel, the Ethernet interface I use for
> > > > > > testing does not come online when loading fuji-bmc in qemu.
> > > > > > 
> > > > > > Reverting this patch fixes the problem.
> > > > > > 
> > > > > > Looking into this patch,
> > > > > > 
> > > > > > > -
> > > > > > > -#include <dt-bindings/leds/common.h>
> > > > > > > -#include "ast2600-facebook-netbmc-common.dtsi"
> > > > > > > +#include "aspeed-bmc-facebook-fuji-data64.dts"
> > > > > > ...
> > > > > > > -&mac3 {
> > > > > > > -    status = "okay";
> > > > > > > -    phy-mode = "rgmii";
> > > > > > > -    phy-handle = <&ethphy3>;
> > > > > > > -    pinctrl-names = "default";
> > > > > > > -    pinctrl-0 = <&pinctrl_rgmii4_default>;
> > > > > > > -};
> > > > > > 
> > > > > > I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
> > > > > > interface is now disabled. Adding it back in fixes the problem.
> > > > > > Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
> > > > > > 
> > > > > > Was the interface disabled on purpose ?
> > > > > > 
> > > > > > Thanks,
> > > > > > Guenter
> > > > > 
> > > > > The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
> > > > > feedback, because the rgmii setting is incorrect.
> > > > > 
> > > > > I was planning to add mac3 back as soon as rgmii support is properly
> > > > > handled in aspeed mac driver, but kindly let me know if you have other
> > > > > suggestions.
> > > > > 
> > > > 
> > > > All I can say is that it worked just fine with the qemu emulation,
> > > > and that it is broken now. Since it was broken on purpose I guess I'll
> > > > have to find a workaround or stop testing network interfaces with
> > > > that emulation entirely.
> > > > 
> > > 
> > > Ah, I see that mac3 was the only enabled Ethernet interface on that system,
> > > so you effectively disabled networking on it.
> > > 
> > > I don't claim to understand the logic (how can anyone continue to use this bmc
> > > without network interface ?) but I guess it is what it is. I'll stop testing it.
> > > 
> > > Guenter
> > 
> > Sorry for the inconvenience.. I have to take a local patch to enable
> > mac3 in my environment, because as you said, it's not useful without
> > network interface.
> > 
> > Meanwhile, I will need to work with ASPEED to enable rgmii delay support
> > in the ASPEED MAC driver so I can add mac3 back to the dts. If you are
> > looking for a similar platform for testing, you could consider elbert.
> > 
> 
> AFAICS aspeed-bmc-facebook-elbert.dtb does not work with the fuji-bmc machine.
> The console interface or wiring seems to be different.

Oh you are right (the console settings are different).

 
> As I said, I'll stop testing the network interface on fuji-bmc. That reduces
> test coverage, but there is nothing I can do about that. I already made the
> necessary changes in my testbed, so from my perspective the issue is closed.

Got it. I will drop you a message when I add mac3 back (if you feel it's
helpful).


Thanks,

Tao


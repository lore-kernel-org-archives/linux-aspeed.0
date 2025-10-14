Return-Path: <linux-aspeed+bounces-2429-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F1BCCD183
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 01:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clx9L36czz2yrZ;
	Tue, 14 Oct 2025 12:15:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760404534;
	cv=none; b=Vxpzym599U7kxDlNtJWcbksxYEtNJKAT5ahj7ohluIzcym6YlYMsBNlTYZZbNzPLS3tMt9oIfWLFIOo7hodwyLE6jKLGD45ptZakNo0e19kc9vNG6GVVoPejc7J8o18R82wg1/6UgVfUMS2gQUqx3az9pcLQxZpVM9oVHyeqpUIy1xx2IxPcwGuZgbgAw4WeYyNcAq8TYigFXOCVT60Ar0zZRhuiuTGaZgz9e9a8z9HPwS+qtfE5ejTe0ZrrRS0DodR1tI6QQloLj10nH2SeCV4T693+nZ8m26sxRz64w7C71MLwj5JmcWT+bCgs5JzibL0D9W0qTRmwR3nI7qyRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760404534; c=relaxed/relaxed;
	bh=phZtlvW8k97758VvwCeGeCQ88PxB75XoJve4vgpnWeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftFTdCUemtun1qCNg+W9Jv9F6wbDyFBLezpS6NuqItAPW/qKMdFlo1duPWrJHwKizCJo059PEXwmLujwnAMWmx93O9zbjxHkyZPkyjmWToo05dOndzI6sPkX3uohUj1ZHdappIZScsb7nVXuSR9KeU9PdDSeHT+lhcW9B1hKAywJREnuwCAO2l+Cv4D578hVIPZPPz4bgrESdgWbBKwTdI1frhSrd4QvYbRvd29QdnVNJJD0fg49MDMtTRXPJSSiDrl2Wo4V61pwGxPzI7YP1Qgz9/AzCYK9Zhft71RC8J5oaWEk8vf6Tn95fpWQ823VVIfVon2wfqKV9O/ckTolAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ayV3Xg+7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ayV3Xg+7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clx9K3NbKz2yr9
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 12:15:32 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-781997d195aso3387746b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Oct 2025 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760404530; x=1761009330; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phZtlvW8k97758VvwCeGeCQ88PxB75XoJve4vgpnWeY=;
        b=ayV3Xg+7hqf4d04d/BuP1TOQkb1rzlGdYdaQgFOfclBgvEtz6dDBkwImFJsVqGPLwa
         KWaJKl7lNSxZvIu4//0ZS6iKMPWYi6WugfH0fnkMfRSyDX+1Bc4ZxMJZvf2uN5N5jkOE
         4X0+Hm9cENanuZ8LQZQ4gmcko46DWSyPs9aX3Imo9Y46NIrFBYhw62dp/vdKnLG5WKGl
         AghuVZPkTcpaK6wbTBTia8q7G87c1WgnsAGg8YVky12QHMT4MuPSsCcq09wJIWnG7uGH
         IGnfrnqyYVayNnw12fNbKYIX/w75Qvdt+yE9XnhIpVf7n+kf4WcdW/30D7iEM1s6Ttil
         GjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760404530; x=1761009330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phZtlvW8k97758VvwCeGeCQ88PxB75XoJve4vgpnWeY=;
        b=QRqHCcHaBWU5Y+Dq6ngy3hbM2JkBl7x+77W6Hk+JvLhCroAqmnA/HuGYI0ywVb0BfP
         AMAP7MAmEMJn+GXT1xOoL1nk/FkV64nps8ZTILTsgdX6GTTjEOkfCOAc8SU+N7S+YY4O
         FXhi8VU5ktnYrWn9wYZcF7uAOP2e/sXHEbpPGjo/KjaqPX7OzN9ISCP337LlAhAwPv/3
         xk95XTwUdIU/R0hz6ojKIRSStxGT1cixkUh2/iJT9WxLOkDApnIvRo52YPda8UvUEVKV
         EWkoAzDvh5M5jqBOpZISYhrcxviPo1oJau6M+F6q4dFBSKS58gMarY0MA9iB+Vzg6unm
         hIEg==
X-Forwarded-Encrypted: i=1; AJvYcCVxtjA2ecm20I+KXpQ2GUqV8cWQbFpbInlQejumo3oGsKmA+6viMx/XFy85aaZWnAySNcgfGepgX0zbfqE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxn89AITkq1vfAnGyqLGRSX8iwjVonomIO32f3AB9p9UMO4Sqzk
	itK9YptWB2lBxBf0CgeiniDOIb7XcDIx1aNFBhRxBCtEAvxLs5PIxjIZ
X-Gm-Gg: ASbGncsYlxYe/7ap48u+o+UKfxxWv41RO7tBjfn5/PinnrQlQmZtWCjjGcRa408yGg3
	W1Muc8cT48GAVEEpXo98fsFg7Kffj4KC7sRjTqjsJV/3GP7dhzFec3xlC++iticElqPLDwYPUfj
	6AuXpPcAsB9ceceVvvhVtG6gh6GD+l0vFhiBmHq0/Nk4RqfsreCVgO71Ca2/2JmiDAs7rEF5wkG
	VXZ6z8QM5c5TUM1AowfsM0SRie7ym1qpZgHxwmgikJA/UxhVmfVh2oNILVF6CV7D+t8m8STeVkP
	4PBmUEVdhqwbjZ2HnXPxmas/4X5WhR7aDjB1fspwLXthB6iSmnNFo8NkE8K/7Opnhwlhib5tt6b
	kW9LWojU5FRlhootEMeoYW71ms6bvVY+F3T5yDIE/93rMhp0zrv10NlSP3mOyVV4Nq2Xk3t93B7
	RT/DT2LQNE
X-Google-Smtp-Source: AGHT+IGc6pF41NoPdDYQMQp8aeLQWIfke286IFthWwuWj9dAjt12ahG3XuGO1XLg+wdmBQpu8UKgqQ==
X-Received: by 2002:a05:6a20:2450:b0:2ba:103:aa3b with SMTP id adf61e73a8af0-32da84ea472mr29893401637.53.1760404530225;
        Mon, 13 Oct 2025 18:15:30 -0700 (PDT)
Received: from fedora (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e275csm13012575b3a.61.2025.10.13.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:15:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:15:27 -0700
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
Message-ID: <aO2kLyxGlGt12sKD@fedora>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
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
In-Reply-To: <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>

Hi Guenter,

On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
> > duplicated code.
> > 
> > Fuji-data64 and Fuji are identical except the BMC flash layout.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> With this patch in the mainline kernel, the Ethernet interface I use for
> testing does not come online when loading fuji-bmc in qemu.
> 
> Reverting this patch fixes the problem.
> 
> Looking into this patch,
> 
> > -
> > -#include <dt-bindings/leds/common.h>
> > -#include "ast2600-facebook-netbmc-common.dtsi"
> > +#include "aspeed-bmc-facebook-fuji-data64.dts"
> >  
> ...
> > -&mac3 {
> > -	status = "okay";
> > -	phy-mode = "rgmii";
> > -	phy-handle = <&ethphy3>;
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_rgmii4_default>;
> > -};
> 
> I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
> interface is now disabled. Adding it back in fixes the problem.
> Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
> 
> Was the interface disabled on purpose ?
> 
> Thanks,
> Guenter

The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
feedback, because the rgmii setting is incorrect.

I was planning to add mac3 back as soon as rgmii support is properly
handled in aspeed mac driver, but kindly let me know if you have other
suggestions.


Thanks,

Tao


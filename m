Return-Path: <linux-aspeed+bounces-78-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B76D1CA19
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Nov 2024 04:10:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XjFHn5TYxz2xk7;
	Tue,  5 Nov 2024 15:10:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730779845;
	cv=none; b=a+FZyfo4eJtTpo9QlVUtLDrHoYNNBQhNZvn8SR7WmRqEd76+c6lQlG67iq4Daw93UNLDnD8gu+GM85OyifsBIW+2tjAEmzlcOei9ssCytVoUIHw0pYZ8O9a9I4+m3UdbsMOMI6JYdboJliDzYzI4hvXpS5ocihA8KzYI0S6S9ip+jKDMuPdQgt0nW1XzXzmKcQZHbswY42C1uu8N0sBSPYxV/ZmZrVk7GdRrQ/AU200VJPjN9889y4ONjD4qMFaEjZjG6Fn6LlvYey4+wPohL3KbaTqbO09l925FnuzSTk4biuLy1D717qwiJBG0n/+9jcJfLAniMJVv+vtzQMCCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730779845; c=relaxed/relaxed;
	bh=scJvZT2Bp+kcd/IoGZ1ogwNGrXZa1xnJU5qHOxNFIJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqeVu56lXBlGCiYrwYix0JRNBGEVob7+pTKMAsKoY1tQvG/GE90pk94VJk/QdMF6e4Imyai9fGzNcKTYKN2aagO9Sx8urn4pmjw70HxwN+GluUbydUfTtT4scoUf994cYO4wOqfgMG05S9QcaP61jjWYj7NH8JDWolWVDtRxhu/omHnAmS1lerDtlK9CJ1MxNtLKNq5RtpAv4pKcJz+qwjRw4E01WgpP2cPLiL6vcsQJGSY/RpQDIoKExEceOhgPvnBtNoH94E0vudF9esHvI/9pxsgct9OA74JBba6mWxa2GkBwwuCUBMSwJLK4kzLnZ3HR4H9/WiePq2Z1HO54jA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=bm4M4/ZG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=bm4M4/ZG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XjFHm4VJ1z2xQK
	for <linux-aspeed@lists.ozlabs.org>; Tue,  5 Nov 2024 15:10:42 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so3594239a91.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 04 Nov 2024 20:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1730779840; x=1731384640; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=scJvZT2Bp+kcd/IoGZ1ogwNGrXZa1xnJU5qHOxNFIJQ=;
        b=bm4M4/ZGzanQqn6RLRwqddXN3Gu72XxO7nfEZaM3ufDXq9nyXLg4pwcqNABSRI0pvX
         IHhugWn2eO6cjBKpwm+Z89IylyZKaF+ce7V3UyPL28aKtRZcG7+nuQYdYxuFidZOc44J
         bxnGNoFUWZBwju5KE10sA2FGMESIiPQaY7ditzH+jFzQW1ZSL5BADZHXQGRCycyZBe3K
         1W3TyOzM/X9XEHAQW2fNvIzk1uGC1UjU9blfhg1Kvq/EU9ZMi/psE7LXarWcRPZDM5CE
         Km+uhahI8CFMTEJ1yVQB9JCHwYGrP29AwSgyKzx0nGbnJnKML6I+DTLx48bXwmoZVytx
         0YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730779840; x=1731384640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scJvZT2Bp+kcd/IoGZ1ogwNGrXZa1xnJU5qHOxNFIJQ=;
        b=T3LCodxEzxS91kR+6MQiOrk9W74wzTo1W4I4Se5nbzvKo4xKWc/4sIdc3q049bft/n
         RUrLAXcuVqtrz5NeY/0eoSg47mpkMo4EwjCjx9OG1jBAM61mUGOJNklQVuVRycE+0Dm4
         Lp17rc691w891IXZkrKjr+lFOS/9GByqqupRmgm9w1lpZLg6Te+9vUW+1Ye/DXv4F35/
         tqL6MBZzGhDnh/ywpVwNpCX1tT7YvSWnGAMXCGAO7zjzjYfnd+o5cBi8ozXv/xW1lxGO
         hRHGWHxWLU4ZGJj2J8G8lvcn1kmrQj2h+qWgDEeJSD7rVUTv5VgnbNK8DVkIKVluXIYs
         DhJg==
X-Forwarded-Encrypted: i=1; AJvYcCV7hq5PSAaXWoW2XR7X8+ftcd1vPP+ZyZAE8nlPbd0U5mJQd1gNrtTGoJjJ6GMw8/guByfdyFuRY/EtDEY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKP8j2YEpdPC3DMjoyCxy2e3ojsHairT5StCxWEqealOj195r7
	ggTlvCaPRbgj9O63mKHeLMADdRo8iZRKv9B7DhwWCralLYqdv6FCEa+//qhvu7UtFrmZzIVw+p9
	m95t53/DyH6mcpJlvSPUhZT9FSCseB4VA4qPreg==
X-Google-Smtp-Source: AGHT+IGScUy3G6UR8gz6wvjEudlraQqlt5Uia9jokVx/2PFVMQBmpLwbRPnyko1K4A9eB9MF28vFRoIVwNeA/WAajBQ=
X-Received: by 2002:a17:90a:6446:b0:2e2:b46f:d92a with SMTP id
 98e67ed59e1d1-2e92ce50e2emr23868289a91.14.1730779839807; Mon, 04 Nov 2024
 20:10:39 -0800 (PST)
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
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
 <20241104092220.2268805-2-naresh.solanki@9elements.com> <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
In-Reply-To: <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 5 Nov 2024 09:40:28 +0530
Message-ID: <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com, 
	linux@roeck-us.net, sylv@sylv.io, linux-hwmon@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>, Patrick Rudolph <patrick.rudolph@9elements.com>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Tue, 5 Nov 2024 at 06:03, Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2024-11-04 at 14:52 +0530, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Add a device tree for IBM sbp1 BMC board which is based on AST2600
> > SOC.
> >
> > sbp1 baseboard has:
> > - support for up to four Sapphire Rapids sockets having 16 DIMMS
> > each.
> >   - 240 core/480 threads at maximum
> > - 32x CPU PCIe slots
> > - 2x M.2 PCH PCIe slots
> > - Dual 200Gbit/s NIC
> > - SPI TPM
> >
> > Added the following:
> > - Indication LEDs
> > - I2C mux & GPIO controller, pin assignments,
> > - Thermister,
> > - Voltage regulator
> > - EEPROM/VPD
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >
> > ---
> > Changes in V6:
> > - Verified all regulators warning resolved.
>
> How did you verify this? Testing the patches locally, I see:
>
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
>    +       from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>
> From a spot check, the warnings seem legitimate. Did you send the right
> patches?
Just checked again. They are resolved. But I guess the dtbinding patch
for the above warning are merged in hwmon-next branch & not in dt/next

Regards,
Naresh
>
> Andrew


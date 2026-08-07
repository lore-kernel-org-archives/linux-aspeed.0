Return-Path: <linux-aspeed+bounces-4655-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73ABC5AC7A
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:37:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcw43SKXz3c2F;
	Fri, 07 Aug 2026 18:37:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091844;
	cv=none; b=JSMR5rlop11Dd6NsM7ZKRXxgv40ptwtEW50ZoqofSpyXE0AlOtA4tiCNNXKK5V0Q91ut6qoFd0n5muxTBbf1nqstv7pTh+sR0GLvybZBwQl510Zn8h2aBr+SFSxP8PIrLLLdlQmwQBiOewCdvzcDAZST/inV4m3WEQ0ut//wyd2SJqGEbvAfEzGiGOnFbc6cPto/9szK69PybKHO0YibxvZaqVfMaTZE6HCBB+0ZP9+WrK9bG8HC9Dq9aAbYFd7j2GORjDH5JcwX6s49oxYxTbtYbxT+NGVJ/UYX9uk6n+XVjzNvZfOOTtp1HXY/uCNbCsAS4Jf4nuO5IfazcD2aSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091844; c=relaxed/relaxed;
	bh=qa/2IU2RbAAtb2QUYjZKVHQ104XeXVbZBNjUDvADO9U=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TCC235UQq7y9M7VwlgQXmt4uIlIVy1NKTvU0DcsbiYvYCeZtyRKNAQMSk6OY8vSu3OnW4lqW5Y881S5oVma14iL2tlrgekWOB3d2Nh1imog+c6R475mQ4uYYQF+q7COmvYge+fJk+hcBtQEp6oVGPOA6fw7eVgEbo3szrLuGih0hfzhwA7Cbzy9bvejZAOwZhp7B9qswIqP2UWJPdM6eJD54zDKVYKegbo/DpNWomyxMxnh0AeHfI7Jb3LbrBW32hSURIEM2Z+qgmHkXJO1t+67vW96L73fWjIR6+FLQdyvYVe/Uh5cgx/B1ox8vb2XT7CVr89SRd8Ko0Dyvab89Og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YbIgusO3; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YbIgusO3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcw348yYz3c1D
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:37:23 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso13507675e9.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091840; x=1786696640; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qa/2IU2RbAAtb2QUYjZKVHQ104XeXVbZBNjUDvADO9U=;
        b=YbIgusO3BZV+50LF73yrpmrPW67AgqfngkFtRPbbpo6q1efYvnQ8bHyNQnJSq6nVRA
         606cLdxaS1nOkCtqAByWkuq9gy74/LaspIk7Se4bL0tGMWrc3RO0T8XpMVpESj5yyXrN
         hQ2mQBIdJVqarwEISe3V1FBu2hZH8zr94QRfZYkStaT2bWUNAaWYcIWkdVULZSrF+e0k
         FFrwpcPWqT6jycWO0TanAkhYdm2tgzEojuS6kVudZo2w4PZeihi9tYPHnQ8mj8ydNQ5x
         PLmNaOInza0GNu9YeBvYUorj5ddn1rVT5EYUABsdrKD8lQTfGksWwlaL4nmwpiEXf8T8
         u/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091840; x=1786696640;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qa/2IU2RbAAtb2QUYjZKVHQ104XeXVbZBNjUDvADO9U=;
        b=TWdHq3vCQa5NG0fVu1GsiKsH+rR/I7fvRMhRuVzgHiQXML0NgXhj2RgudhgzMcmgqJ
         5Ul4P5cmgZRlhd+aEWOALMP+GDuBI7Wc6rziDojrStFP6nZYqgaTw3Ee45dhW6xGwnu0
         heKi9OytCQRHubuwTR+amjHjWzSciRjcjThqxtBEbOQWk/OiAmK8TETZ9USldGPWp9Ga
         K5NttS2cf3ilXZp2c80aGhxBdH7YMuREscIfp8PJjn/aKRFUbmG/J74OzUIXys4RHC7+
         8XYey9DEHPVVhLz9926JuNBAndlzP+PuX9Xpcplx3aLyHcTd8XdmxLXNvAbZe3bEAjuU
         JKfg==
X-Forwarded-Encrypted: i=1; AHgh+RrkDH0p3kOHNV5dlqrIsgHHuk6XFr7Pi5A9DHkZl0h4YLCIpMkpebwMrLnUvygDNiFF/5yBw2DV74Fqdu4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw12AiApyFHNxatMRblPsAoiz5DmxwsDhOEgXFh2hiuYei9IIGa
	Y8PLbBc+C/5/kAVOi4ozRG6i57CLrXi6piXsxweV9R5d2r1puSREhE0QQSiiKYAH6os=
X-Gm-Gg: AR+sD110uEGUJaQKjqK4Xi4dW7iGk5qJqb6HKKCCwQXpv+4TScFB6m6+lJqzfHcecUM
	VqaXEbJv+1DDPONjJPSoxcp4HNAhTGiUQDRa6emVE1FfhVJjUe9c59unrh2rt3e0RYEwHxwTAtD
	mRgAXwO84jmj55RvIqQGTzw8rRFpmxd8594r4QAXmK4Kak77mS4SnHibD7iwPuDUITbL9/Hnp+5
	BaABHf69yI7J5BeM6YEAc2b1QAnbTnBom4ej9o5dh5NGOKM+tv7dMvV9XFlRMPmWPthF2cj9/Kb
	i5r5KzSzIFKgcXQzfvzpY7L3KabxkfjnFLhNHGakwTVzbpj9H+0Ork7Wi9RBsIiHjhUvbBV8itV
	8BQpweDlKD721/1smFanQ3k/7ej6EdCidRFERgf2XBHQvbm31F/H9En3F3dzPyHO/5c4zYBOvCh
	vaIeUNBJEKZikB9rF7n7/4f19sbZs9RzcJCmsR91delzb76zSYbTmAksMBNCU22Kd+ZYcV22LK/
	g3s3MwHUQ==
X-Received: by 2002:a05:600c:19c9:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-4995f8083c9mr1877075e9.7.1786091840306;
        Fri, 07 Aug 2026 01:37:20 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:20 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 6/6] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci
 prop to vuart3 and 4
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lee@kernel.org, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com, tan.siewert@9elements.com, 
 linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <8d24d424b3504105394055de268e0a11515635a9.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <8d24d424b3504105394055de268e0a11515635a9.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182924.193353.1528505361399129387.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=2379;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=/UdSyTf9Swt5Ml5qDkK3fqt0U1o1wltMS/fTtppqJ+4=;
 b=Td0FBVHZjwGzgXbgiKllL4oZyf/Dbkogo3BlU9t3xclOt5YoCOrEbt8mL9QHVk7XLfkFRJ7Wa
 6EY3etRH2R9C3Q3YQKlDY8mjaPAEc28k3jIyzjAH3Oq3M2RB4ymHQFB
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> The VUART 3 and 4 are VUART over PCI.
> Set this flag to indicate this information.
> Also set the syscon phandle.
> 
> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 7c02633f2bd6..fbd7ab6332a1 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -722,7 +722,9 @@ vuart3: serial@1e787800 {
>  				reg-shift = <2>;
>  				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&syscon ASPEED_CLK_APB2>;
> +				aspeed,scu-syscon = <&syscon>;
>  				no-loopback-test;
> +				aspeed,vuart-over-pci;
>  				status = "disabled";
>  			};

dt-style check fails with:

    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:723: [property-order] property 'interrupts' out of canonical order (should sort before 'reg-shift')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:724: [property-order] property 'clocks' out of canonical order (should sort before 'interrupts')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:726: [property-order] property 'no-loopback-test' out of canonical order (should sort before 'aspeed,scu-syscon')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:728: [required-blank-lines] "status" must be preceded by a blank line

>  
> @@ -742,7 +744,9 @@ vuart4: serial@1e788800 {
>  				reg-shift = <2>;
>  				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&syscon ASPEED_CLK_APB2>;
> +				aspeed,scu-syscon = <&syscon>;
>  				no-loopback-test;
> +				aspeed,vuart-over-pci;
>  				status = "disabled";
>  			};
>  

Same here:

    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:742: [line-length] line exceeds 80 columns (92)
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:745: [property-order] property 'interrupts' out of canonical order (should sort before 'reg-shift')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:746: [property-order] property 'clocks' out of canonical order (should sort before 'interrupts')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:748: [property-order] property 'no-loopback-test' out of canonical order (should sort before 'aspeed,scu-syscon')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:750: [required-blank-lines] "status" must be preceded by a blank line

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>


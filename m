Return-Path: <linux-aspeed+bounces-2977-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326FECFC29A
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Nov 2025 19:21:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dClSV6Ntrz302l;
	Sat, 22 Nov 2025 06:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763752874;
	cv=none; b=V4sAteOXGbzd8RH7UfbWt8qI/Y1FQGLo2iyoNAbMWY9LMPr5nmeseRMDtsvuv3zHt4IwotsdQxCz+K7fUiGrfjnEnxYSnscYD2a9rv/fqHjx+rjPdYSlT4vBq5iSi4oLcbjLWLDClSjJLXJuxnMOD0FGdLbYN9Jeqkj04ZFBN/2pt9ltAIBOxl2CCDmPzzzNDkxcJtEYEg7muAuxoyngshaTATREXd+tXI73+oGl2hjhES7SEk6/XgTNbonj5dEnIATTv32WT823t1vnf9Sh9q3eqGe2zj9rVEb4plqIgGOMWWSEctTE54EWOHefrYQUbyMc6enKN1uIutzJEpPn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763752874; c=relaxed/relaxed;
	bh=PuwsRCiJEfPqcQBjl8MxdvP+p6un2px2w+qwWN+KPP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU8XnpbZ2OAvPOQ9KzCHTuPIqWBxVT9DhpGIlQ9ZRZUDXq15jdQS8531C3yPUe+Fue0ncpyxWrc3Ky2WIMLyeMU8AeEAaJtx3NIgjJ0Y+528xLP/c7k2tv7ABzxm7+nBi4WUJNcWmHSyeQzPFCLfih3D2+VV6H/pbGfr5Nx+Ro6ejeQDPVBVj2apsT990Bht9lhjmr9p8z+qNf2SMYsXBP7mhalxklvuotKtrFUqru4EXoz6gDGVGgm9UwVH2XGhepBsahqC61vW5Utm+474cqljC7QvceagdXyNOSet6YCWSc2IlAQYmur5Lx7b+cD39elgQpjoUB6CfCuzmBGSYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SavFDUxT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SavFDUxT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dClSV2HHPz2ySb
	for <linux-aspeed@lists.ozlabs.org>; Sat, 22 Nov 2025 06:21:14 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso2648587b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Nov 2025 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763752872; x=1764357672; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuwsRCiJEfPqcQBjl8MxdvP+p6un2px2w+qwWN+KPP4=;
        b=SavFDUxTWB99xKKVyM7rNA/SoBlLuU7SYM7NPYS3/VGIJa4+Z4wOpFbhwk5SQxVJaI
         IYkuTwFjio80FMzsZmJhIe4BOQrfuXW2bSXSGzXEjAKFoAE7J1alDv4wudYf+cLEjIZD
         J3MDf5hlAF8UD7G09JsbNKxWx9vE2kvdOP0pj1heusqLTRgcAYefwbNNbAxC0MRZihVK
         wFuPJq2j6NN94iojARNUJHy4iDKXTCGC1o2ioXgryhNOzt+HPtqdz2ni5+gtPyY7oYws
         hqDhBvbJi+dSD3NgCAgDBog3LlwaRp+v5QoveOBoRL25hlmxWgTKUQw2U2zNdWlL0Paa
         lL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763752872; x=1764357672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PuwsRCiJEfPqcQBjl8MxdvP+p6un2px2w+qwWN+KPP4=;
        b=dHNQ9uz4/P0RUpAIJ/o8Z9zdzJiuU6hGoaJjdjsEAFn6jj2L1a+c4W9hakjC7dg2Uu
         KF1QwBOc2Y+juGKWFeIrpMEjNOqGl2e+02g3aO9Z58mgrALvQTEG/gIwLKqRzqoBWR3M
         YtqzX9KqpcBwXbl2Zd7jktklLcTySP76nVF1A7EaI+5BZXrh+UyspCJiQYzDdBiAQS+2
         jpdwiBV5MXSXjF1XFnuivJ1cqqfgbaFp8rNgp2lhxCPGFiqqEE1ORX3idu7sYmvfGMGQ
         XEcUMFysPcbJ3mtUAAV19clehA89YHb9yhg2RIISY2CEg0uLhdNNp2ppbF7k7jiVvQKR
         yS6w==
X-Forwarded-Encrypted: i=1; AJvYcCVNhulSafMrZBLwwtrSf7XGlAazV/sHvux1zw0vM1f8bnTesOciJb8+Zi993LS9bUFl/Rqs3q0/2Z9vbLY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxhn9L7MhVgzehylxW75JYoUArZfgo7tnzCkcgXE9p/TmMmgxeD
	PQkEJibHSLX679z9rE0YciSSY3rhXmyKfS0WzVuw66WZD92N5gbLkKhg
X-Gm-Gg: ASbGnctfhEY6SF1rUQJVWymG4V3Bg+uOhfWD6q0924zcj+tkBJim3llbyURg1+0Ev6l
	S2G60mldB+281QKdpbFMmIO01BJbTOYRWqE/E8ACXu2rwnC1hJoMsWlSUq7ivkfFqTMejlWblSw
	LWRTY898S0dsLMZ/cgciufM5sChTXxRrDn84AztSTqhS9YMVqeR3DQShI3NnCX2Ob1UiJZ04VWL
	0F/j8pHAz55+CC9qgGL8HizT0feGyKWHPa5UoyMCqixfuWi0dv7z+NDHwsRatwVHCEbQqEv9m2E
	AXiuOY9oVlbXr9t/QsaSuRFRxUfb96yKwK+sh0R6WdG5CB+6vPPD4xjyFIR0F8jvNe1rTDFX4Id
	5/aBupsPuTHp10PM+sp6wO11Gf36tKjBpUfAgObvOcfl6V500rgz+qyIgA6WqMuI9vdt6cQ0drv
	+10ePSO7cCUbWemVXDNGf6pAs=
X-Google-Smtp-Source: AGHT+IEL7H1VBi7kwbJmZG3DtyIxfrQ9k12/GSEXJJ2L83oQNAI/YlBkWdpeqhPFCdtjoHJfPOpsbw==
X-Received: by 2002:a05:7022:6729:b0:119:e569:f258 with SMTP id a92af1059eb24-11c9d70a16emr1089561c88.1.1763752872115;
        Fri, 21 Nov 2025 11:21:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc204881sm25316159eec.0.2025.11.21.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:21:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Nov 2025 11:21:10 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v3 2/2] hwmon: (aspeed-g6-pwm-tach): Add AST2700
 compatible string
Message-ID: <30d139b1-05e9-4629-8a95-95991849fb03@roeck-us.net>
References: <20251120-upstream_pwm_tach-v3-0-eaa2f9b300a2@aspeedtech.com>
 <20251120-upstream_pwm_tach-v3-2-eaa2f9b300a2@aspeedtech.com>
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
In-Reply-To: <20251120-upstream_pwm_tach-v3-2-eaa2f9b300a2@aspeedtech.com>

On Thu, Nov 20, 2025 at 07:12:32PM +0800, Billy Tsai wrote:
> Extends device tree support to include the AST2700 chip variant by
> adding its compatible string to the device match table.
> 
> The AST2700 PWM/TACH hardware is compatible with the existing driver
> implementation used for AST2600.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Applied.

Thanks,
Guenter


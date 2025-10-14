Return-Path: <linux-aspeed+bounces-2433-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D06CCD187
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 04:09:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cm1262KpFz2yr9;
	Tue, 14 Oct 2025 15:09:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760414974;
	cv=none; b=BDL28WTP/mClT5AGjJrYQIVkPk/ODFnZ7pUmrJUJC7GfnqNx2hllh2+AblX8dHE1UQO5hRXWBfGgTKMAMknMSeo5mFEjBgWItuE/SlNcIMkMlOliSM0i2grR1cKR/iJQdoSnPi2PNIWBX90dGHXQiFuFC3tOcLCfCPmMIpGZYyPB7xHDaIODELQogeQj3gTiwyuwoX7f38A3jl/K1IXKrXTphBdxS2H1sFEryX5ophOIc5oDKaPUBd3qrbpd5LYkhts9dF/A1XXmIzPXYssUdGvTDNWycH/RgJpGvsdCIk7DGhpqO9dVE65bruCCmp3Kl2rVPD9u9x/tAxZfGIOrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760414974; c=relaxed/relaxed;
	bh=T0FUz4z1xFNwCgvQPUMrt9kZD59yR5IRPj9qAd263rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di7VI2Ka4BZQqzwA0/FDcUyMn7mN/GDq7ZMgYCNaT3kUy/zy3DnRUAmm7DVrLkX/ofy8Xyg3NLPdDKEcuapssmXExbfdHLyMbRVBlBcRh8WBMpaQCIu0hE5ZVSrqx21z+CFSip3pYrMBoNvBfop6/Eb9Vl6tiw3LsStO6eLCad7CIC+LePg+8b0whS2z2fLXDt4SMfx6sMLNQxW7mG39JnSVAFGl4b85UjXReeby1UcFCzb9CGCTMp8yIGE8TIF4teBdKFlAY44DNZkraJuVy3jdweKgelZ7V+LtWI09cNOHUC2tN/zhI3u2Soc0p76z47q3egbASYQN6Do9A3TFRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fYUYN7u9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fYUYN7u9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cm1252xstz2xQ0
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 15:09:32 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-27eceb38eb1so54933395ad.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Oct 2025 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760414970; x=1761019770; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0FUz4z1xFNwCgvQPUMrt9kZD59yR5IRPj9qAd263rQ=;
        b=fYUYN7u9r1Can5BW4Fr7ftoiYksN+ljRkbODLIH50ZxzUQa3e2ZboO20bg6NfPZnCV
         WpsOeclBnawSqpeNYhDbVHAAAfXf8mseGmKUXdK6zdB/XT0eNLSHhZUUr9Tk+D9fjfH3
         cmJQP1lFzzN3Guv0pRSH+/w/YWbK0P3xMiCVkfpxIHyqCTK5prYngeMuAbfzkaFSm2Ee
         uZNzpZGwuyyHOgCftFdMhtE4/M0rJJBaiqvhMwL7SPfLXENa7Juei/qFy7zri7YyxtcQ
         MW0hc+LU5D//XmjqJnJY8+aac2rdVbUvUrtSJB0vDdg2jw7i0A7i1AZ5OXM0334N0YCB
         EoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760414970; x=1761019770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0FUz4z1xFNwCgvQPUMrt9kZD59yR5IRPj9qAd263rQ=;
        b=XGReBkqSOw1jgytweBi4aSilD/w0wKNZnF4xUVYsVJB1JUTND1/zgLd48U3Kyaqrkc
         wmqRjZEo89uZz/ZawSUQnu9pw4XjuTYo/ZmbwSchVkT7L2pPZurU+eKTNtel2LGQV0e8
         Hn7UOx4Dr9Um/metvSO6ZNdxkIGAsgKvfkWn4e7iepwklK6S6svAJHFCRt8g8etupdSX
         rnYOZDbnL4np4lM+7T3C42lJGsIVwReYTotBbw0v/U49qLUKEBeQ+EQHyYB/nvtvkC37
         iuv2qwHHSnL02qXkHVpN0wpplHhDc3hSDs8YbXa/E+Esm5RCrr3sXaHDZ4RIGgVVW2/f
         NNbA==
X-Forwarded-Encrypted: i=1; AJvYcCVZdXyOxcU205bdTNjKoDNqWTKNSQFufXi1dN4Wsf6GTQj9NggO5c9ZhI6cBH39wS3ZMxvcG8xRg7yedJA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFiMnpkXq/0itbZnkkQykfGYPGsixqgfwCipEC15LrfY5jj11T
	Os4UtwIoWzogGWJWgo4XkP+wr0lWgs+PTyRLcfv0Ymvk1QpFCYEEurSs
X-Gm-Gg: ASbGncsLHuk4t53/U8tkF+0PiQG2rB3efbJa5OSGkNzQUgH11Osss0YhiJfvw/n/EpI
	fBGwA2OMUnKJ12jlLIKZrYJYzV3RBu+Vs6OYP3G93lH22sBlDlD18szqtaCPV051QSHhcm1lQQX
	mbZz46DvsqIkPpZp1SND/WWKDulntcRezpdUX1lrmT9XGUWi2N/UE1JJAJ6hKGvx2DKZGFl9AXS
	bXPFZeclDrtz9k7YRDWCclHmO4/pTikA8gmHZprwjlXk2OpdhZMSUR0TFt9buJMfab+p62WlUv+
	HlTYVUh5+oc6lAWvLkPfGUWvly2D7Bduh2HysR7kYXA/APfVmMMsApnLVRAxkN75tK6mOx8S4SV
	sAz9zt5xiV6gimI15g9IFDOsEVje12TmBxX4OjTfbYpJz7kgKtCC4OZGYKyPHk5i7D1VqRu3xeW
	Lup3EJ+rmOESGGbY3SJ34=
X-Google-Smtp-Source: AGHT+IEr20kAH+dfqBTsSZfMO0yg/OwD4bgTloNhcSIQWl/DGKL1nIf9DZfEY5q5FY5iCmPtfo18vw==
X-Received: by 2002:a17:902:e806:b0:261:6d61:f28d with SMTP id d9443c01a7336-290273ffe94mr274157815ad.50.1760414970372;
        Mon, 13 Oct 2025 21:09:30 -0700 (PDT)
Received: from fedora (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de5dbfsm149146305ad.20.2025.10.13.21.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:09:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 21:09:27 -0700
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
Message-ID: <aO3M90Ycp2DWyFuk@fedora>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
 <054cf209-61af-4d21-9a3b-d0f6dd24ee3b@roeck-us.net>
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
In-Reply-To: <054cf209-61af-4d21-9a3b-d0f6dd24ee3b@roeck-us.net>

Hi Guenter,

On Mon, Oct 13, 2025 at 08:44:17PM -0700, Guenter Roeck wrote:
> On 10/13/25 20:20, Guenter Roeck wrote:
> > On 10/13/25 18:15, Tao Ren wrote:
> > > Hi Guenter,
> > > 
> > > On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
> > > > Hi,
> > > > 
> > > > On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
> > > > > From: Tao Ren <rentao.bupt@gmail.com>
> > > > > 
> > > > > Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
> > > > > duplicated code.
> > > > > 
> > > > > Fuji-data64 and Fuji are identical except the BMC flash layout.
> > > > > 
> > > > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > > > 
> > > > With this patch in the mainline kernel, the Ethernet interface I use for
> > > > testing does not come online when loading fuji-bmc in qemu.
> > > > 
> > > > Reverting this patch fixes the problem.
> > > > 
> > > > Looking into this patch,
> > > > 
> > > > > -
> > > > > -#include <dt-bindings/leds/common.h>
> > > > > -#include "ast2600-facebook-netbmc-common.dtsi"
> > > > > +#include "aspeed-bmc-facebook-fuji-data64.dts"
> > > > ...
> > > > > -&mac3 {
> > > > > -    status = "okay";
> > > > > -    phy-mode = "rgmii";
> > > > > -    phy-handle = <&ethphy3>;
> > > > > -    pinctrl-names = "default";
> > > > > -    pinctrl-0 = <&pinctrl_rgmii4_default>;
> > > > > -};
> > > > 
> > > > I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
> > > > interface is now disabled. Adding it back in fixes the problem.
> > > > Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
> > > > 
> > > > Was the interface disabled on purpose ?
> > > > 
> > > > Thanks,
> > > > Guenter
> > > 
> > > The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
> > > feedback, because the rgmii setting is incorrect.
> > > 
> > > I was planning to add mac3 back as soon as rgmii support is properly
> > > handled in aspeed mac driver, but kindly let me know if you have other
> > > suggestions.
> > > 
> > 
> > All I can say is that it worked just fine with the qemu emulation,
> > and that it is broken now. Since it was broken on purpose I guess I'll
> > have to find a workaround or stop testing network interfaces with
> > that emulation entirely.
> > 
> 
> Ah, I see that mac3 was the only enabled Ethernet interface on that system,
> so you effectively disabled networking on it.
> 
> I don't claim to understand the logic (how can anyone continue to use this bmc
> without network interface ?) but I guess it is what it is. I'll stop testing it.
> 
> Guenter

Sorry for the inconvenience.. I have to take a local patch to enable
mac3 in my environment, because as you said, it's not useful without
network interface.

Meanwhile, I will need to work with ASPEED to enable rgmii delay support
in the ASPEED MAC driver so I can add mac3 back to the dts. If you are
looking for a similar platform for testing, you could consider elbert.


Thanks,

Tao


Return-Path: <linux-aspeed+bounces-1837-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F87C87FCE
	for <linux-aspeed@archiver.kernel.org>; Sun, 27 Jul 2025 05:57:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bqW9B0T4Rz2y2B;
	Sun, 27 Jul 2025 15:57:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753595853;
	cv=none; b=aGHXS0+F6jYKixU/L3I/tbfJiWXNut8TfsLbPJeGxMJ+AlpboTwEv0zfFKNPNM5lkMa+zwIkvbFwjUWKqbYILfIy2GPsGnyioO0ShmdXA+CSQbzSYMiWMmyDm/EWxTPQR7U2lraVPEo+zjwUYjTiIRE6+mk+msPA7zwK0Fbi57q4WlJxeLveAV7tOSUgLmO+SyI0HJrUi40dHVFThaVBK1HNy+auh/xvjV6Jd1nyVPbich4goJuH9LACaeZBT2Xl3qcrHRbXKpRwrcpk72CQpDHPHgp/uFoD2ks0YF7LFfputwZjJCLgaIY0J5e5/OhQcYsJInx1xQJAdUKB0gjp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753595853; c=relaxed/relaxed;
	bh=ouaLqm1R9pYu2kjb2/unKvQ+wVyFyZBELlahYoTUXkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AavbfXhNI+CaWLHwJehtAsjZUxEhlICS+ApbIXDJvWSOBDT0DWdsldNqGwLXB7iWB0Isvrj8xHm/tymWTc7B08PIpTw1fPz1JGiRtUWpn16a71HQ/GeoZqQQClzgsRvkkZtCBW25gvC+IUMzic88GskUFv97V8fxrvVWjFJNgjtNbKyh0Ce0YSxWE3A/6tZJSvggl42rExgOPMmAjj/dTq5byQD5cZnDOkYL/lnpP5bPI8kYJmQ1ODjmuI0sKU0Lk1N/8oZUVs2Lb/2qgSa640n3dt5NHAn3vfHXWXUthyo7X6tHEUj1JTjrkKsrAbGRLaV12RwHoYlpHA7OQKC25Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KXWoXn8V; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KXWoXn8V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bqW981fNHz2xjP
	for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 15:57:30 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-235f9ea8d08so31956855ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 26 Jul 2025 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753595848; x=1754200648; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouaLqm1R9pYu2kjb2/unKvQ+wVyFyZBELlahYoTUXkA=;
        b=KXWoXn8VR32TesVdgtWcmsnUqIlvrg7neo3iVV97ATUUFyCBnEb5zhQ4vdW3JrLc/4
         zryEpg+Hh5MJh3uLYbYYqnA9m+CexNbB8AJFASFOC50N7zNTVoPzHmfWiQ5qflqCOgOi
         6ud7qIsndxOKc3IBdRchDNCJeDsNM7Xi0YmQoET1xk/Ojr/pKmoCninfiXJLf/mU3rlQ
         n2U3zzInDA89U+4E8NBgHrAzgiqMtOgAGhiYUWhRM+Pu6NyEz4/TZI8NAnF3e1/jhGCk
         NnlEDLMglIMAlR2rohMIBruU+Il4lMMfvq93gHUk5UsrlBCWVii8qi8vAATbE82t63O8
         pyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753595848; x=1754200648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouaLqm1R9pYu2kjb2/unKvQ+wVyFyZBELlahYoTUXkA=;
        b=mXxEiJGJbaxabt2AbO8nuWEtr+2WywuS/voENN/oYCB0dGWyYDi0sEA4eN3+Slf46B
         KWD1klQ3P/pj5yD+cBZ3ar7OgS2xV5vO7Cv+3lKCKxTd9+MX+9O6V8V4Kz2m813LcHgI
         RPPv/jAubYFVyRD0mvi8pt5jA6vEk+tCPS6YGoWVqyNgRFe9i4i4lBBCX2kEydS3sr/1
         Xxxey4D5LckQlcWS8UmZPCk/hom27VSt7SsZTtPhOKg7QxlKw58/97KgVonzfRzb4+b7
         4eYcMLGwubevS2tZu8SE+HRKVFMIJ0r+MqzuVeAmVlJYNyxoVtQri2NpMRgzg1MqgvwH
         olig==
X-Forwarded-Encrypted: i=1; AJvYcCVfJXbd2rxLXxWnv4zPkIgJX89FeWeGs0bl0b+XnGoMvqCKxaXE8IFU7Ll3iSOEcY0nsz6nGPPvq4GUfC8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+piTQalKmIGZcgTUGSak/vSF/YdDWTTe/RJ1OAG6k5YvcmPET
	HFSAEbO9BaYw+vFH0SwocZK+YFBDvpS5EMvOfxnZkR8uu0pufySzKM5y
X-Gm-Gg: ASbGncuxC8sEX7C18rsxYNbOHjpgK9Btep1KF0Jc5x4cPRs613jZhtrN+J2rWbEVHSc
	Cmkj7xZDhQWeUk7ftx810y95FnZBaGqwnJqITzq3pOnU7fIS+mJZefFsOmiHhDpB3V6/ZdE/Fnw
	c18gjLWZQb0fGDnh1iPKS3eKcQeCYIG/NnFc34RW/b69BBqLE0FUVkHvD01crqfHMhjNwtukYrg
	IpOpU/TqQe2j90Cx7m4hTAULQJxA4c2O6mUMMuN70lpCgJs/bmcfi2fyHWqjr+OdySCeVwHnpie
	Re0r8XC/HXN9SnsRy9XdzjrzKS8vV6M9Q0/aAm6gIy24Ak1MmM3zjxDHqfsPJNH7oLb0xQsBboH
	0R/V66p1wNLbL16k9UitQv3XCQeEzx8G0Zw54SWMnZc90ar1h0U14eTNAB5cg0wOnR26uFMRie5
	0=
X-Google-Smtp-Source: AGHT+IGq8V6jL0qsxc/xLYXjd9K12nmc3vEi5z4imGq1hQgK/s5MM/Z/wf4Ba/rfxpwQws59Tqe8tQ==
X-Received: by 2002:a17:902:ce8e:b0:23f:6fa4:1567 with SMTP id d9443c01a7336-23fb2fefd31mr99604175ad.8.1753595847477;
        Sat, 26 Jul 2025 22:57:27 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bce5sm28251825ad.27.2025.07.26.22.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 22:57:26 -0700 (PDT)
Date: Sat, 26 Jul 2025 22:57:24 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <aIW/xEfJX/UD1kje@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
 <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
 <aIMTvUyHGd/ikKY9@localhost.localdomain>
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
In-Reply-To: <aIMTvUyHGd/ikKY9@localhost.localdomain>

On Thu, Jul 24, 2025 at 10:18:57PM -0700, Tao Ren wrote:
> On Thu, Jul 24, 2025 at 02:53:39PM +0200, Andrew Lunn wrote:
> > On Wed, Jul 23, 2025 at 06:03:49PM -0700, Tao Ren wrote:
> > > On Thu, Jul 24, 2025 at 02:03:20AM +0200, Andrew Lunn wrote:
> > > > > +&mac3 {
> > > > > +	status = "okay";
> > > > > +	phy-mode = "rgmii";
> > > > 
> > > > Does the PCB have extra long clock lines to implement the 2ns delay?
> > > > 
> > > > 	Andrew
> > > 
> > > Hi Andrew,
> > > 
> > > Thank you for catching it. I didn't notice the settings because the file
> > > is copied from the exiting fuji.dts with minor changes.
> > > 
> > > The delay is currently introduced on MAC side (by manually setting SCU
> > > registers), but I guess I can update phy-mode to "rgmii-id" so the delay
> > > can be handled by the PHY?
> > 
> > That would be good, if it works. The problem with the current code is
> > that those SCU registers are not set as part of the MAC driver, so it
> > is hard to know what value they have.
> > 
> > 	Andrew
> 
> Hi Andrew,
> 
> I set phy-mode to rgmii-id (letting BCM54616S handle RX/TX delay) and
> cleared SCU350 (MAC3/4 RGMII delay) register, but somehow BMC is not
> reachable over ethernet.
> 
> Let me see if I missed other settings. I will drop the mac entry from v4
> if I cannot make it work by next Monday.

Hi Andrew,

I made it "work" by updating phy-mode to rgmii-txid, and it seems like
AST2600 MAC introduces RX delay even though RXCLK delay setting is 0 in
SCU350 register.

As I'm not 100% sure where the RX clock delay is introduced, I will drop
mac3 entry in v4.


Thanks,

Tao


Return-Path: <linux-aspeed+bounces-1841-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D007C87FCE
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:34:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br6cM2X2Mz30Lt;
	Mon, 28 Jul 2025 15:34:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753680883;
	cv=none; b=ZtQSWbCpxE0Qg28QKJh8lDJUD+V+Z8OjINNRei29vVNRShJb825tNkb4huyFtx/wxUGDbOrENlN5/hw/IpyC/jh0wxxD0F7dG5FzXSwYHU9mtg5Fwj17vApyufAAR/O7NigUYMTXLqxwX1C/Be8yV7KLwmWqgiZdR+U/jZ/S51pvkzFt7rV6SkQ4CsVE0ub/4Qyk1L6knYR6nrB/7j+At7gOgAZk3fDgpnS1XFurMi0NL+ArK1WgSKg7fRDt/tkD6pufS5JAGtg9NqOwPpWFzjUxAL5m97G09a5Su5YEnGHt+QJGzKgGPaTI+rNKIWfsmfucuQUPqbYdWxu2/Trdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753680883; c=relaxed/relaxed;
	bh=k6qTA6cHT7QQtMvCxkLbKuRSVS9SJ8QTSZ6o1ZHsFO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJWcJDZnfUjLprg0j+2gVlpd4LMOmeADQzlcbOZxi8xr/nWSgz3fq1X94isrDQ+TcV/btnFQplJ8yxHTAN8/7QZwGs/bobZCxCOkByymlMFllW/maD0+eLRW3lQ4BUd/yxaQ4pWb/R6dUYveFIAp1PCdPZju19kGulTtpmifJmtm0YizVrIp9w8WLHv5rH+2qgWbPciGpIt6VbM08wF/myVdnUoXgHY2GKXFpeVkleEdtP+rgy4fiJaHXOqZGXgtdjCv9BgXu+kjbGn+cdbzp8hCBlfn6y9gMQ2yp/hkF+Ia351Ieg8DXLMQNa7LNRkY/WIHHoxfI+OsTwGsoBbQcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RsEkgmzH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RsEkgmzH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br6cL1hPLz2xRq
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:34:42 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3137c20213cso3858326a91.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753680879; x=1754285679; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k6qTA6cHT7QQtMvCxkLbKuRSVS9SJ8QTSZ6o1ZHsFO0=;
        b=RsEkgmzHCQ0DHImCZlPaDIqsxg05aiLWY5/kjTXduzDf3Jhk7y+JjWg8SOmmN6domp
         XsklBDDl8JhMuMVt3T8R4eIMng2eEYd/Q/q1bwlF1vannLR2zXSg0mhgR5CYtj17Niwg
         pw8O/Y1mroWiI4vt9qKsetYGtL61ILshHGND5HZ+qEiD97PPIqYGwYs5xcMa08UjgaQ1
         UYFDIxlyO1dCG58DJ7bCY9Y79Z+ehu9t3yIbppEuQwmPfFsWqF9JqQOBCll82+U3NViT
         zu2RUbP0PUF7p/jafcaf7970Ss88C4TbWhXVbaLsUxhv50gN7YCfbMcXVeNaNKz07qzt
         VrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753680879; x=1754285679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6qTA6cHT7QQtMvCxkLbKuRSVS9SJ8QTSZ6o1ZHsFO0=;
        b=X44X5R8JfC6BRmFYRSz9ltyLHliNzbNA04D8Q4AMFrsd5aNON3FKao4qT9PcJpdFuF
         bh1PEe1gzukLa3X7N7HDq1+2lelfIB/17vB6zjPY311SLCkz9h2BfEImZjBgO4bLenOs
         jrzuwQWi00l8Op7gcglhYqtp9Bs1wJZBiloGBvURjjaO8oGic/i+OqU15ysm55MzX7Cj
         l80i0yZT39wV4VUOJJkBSpWRYhzXxugForAvdTRMTkDNANX4e71O9f5fMIcjESCcc6vM
         e37ry0nExMFl3JJFvvCx280lgazAvoAKKIw1Iw2tJfgCJkr5tQiCaFhYHckOX3wC/xui
         DSLA==
X-Forwarded-Encrypted: i=1; AJvYcCXai25ShVnWv245AIJEZx4DkNvppUpvKl7LkFehJDVHEU3tzKLCEBPp8wK1tr02N7mn8iq2JNHQh8f5eMQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQTf0YQuPVSH5jqfMKImZ585kts88I0nyZvB79UcA78IWywCGI
	zorb23s+chdMot4uLheavqSxCG3BGRi3FhSni40hyOtBPKJ/2Rhppjjo
X-Gm-Gg: ASbGncuOyNm4IOz7XHfaE242S/sfOOOfY/K1HpuZSS6NicjtCGWzz89Bi3sG9YubYVJ
	n9hgn4zNR+BVCuW3YVy9ftOJRrvxI/mHJW8xKB1ZvaqQ+rcwvcDMluG9hQBSgtAE2TBW/BPbDzg
	PU6ZTxHnFXyilr6dADcZ/aCugx7iXeTWxfUD8lqJAHpeggiMqNOKIRKikYTSOM+Ql7ZN95ol3Zz
	LXqADsnufwquGfSqKFQAfgarW5mb/Wf7gK/PyK9C25Wkisx3MbSVY4TaKrf+aB85Pata+2gzbiu
	9Cg/LDGnkLkps3hSdyxxfW1/DN/p4iYxHyO348w5hWooeuqrs+cudzgr1wZ/c+6zEem8yxGtXJW
	cOfcFYF6zhHAjMxE1VVeYEdprbrCCzCmSWEw2SxT7pKJcWxW0pqgcMOQ0WtIC1J379kDoR8THjU
	o=
X-Google-Smtp-Source: AGHT+IHvKUeJgGPP2KuVZC7MV+slZ+Jy/0LanvshipPIkk1k/Fwjh/2vrhM3ta3T+sWIO3FTVGbo3g==
X-Received: by 2002:a17:90b:57c5:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-31e7788cef0mr14119890a91.9.1753680878918;
        Sun, 27 Jul 2025 22:34:38 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e663a71fbsm8559351a91.35.2025.07.27.22.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:34:38 -0700 (PDT)
Date: Sun, 27 Jul 2025 22:34:35 -0700
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
Message-ID: <aIcL67c4VufhfVMY@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
 <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
 <aIMTvUyHGd/ikKY9@localhost.localdomain>
 <aIW/xEfJX/UD1kje@localhost.localdomain>
 <9897e0a4-7c70-4e27-8591-09e9d6ef2263@lunn.ch>
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
In-Reply-To: <9897e0a4-7c70-4e27-8591-09e9d6ef2263@lunn.ch>

On Sun, Jul 27, 2025 at 05:45:51PM +0200, Andrew Lunn wrote:
> > As I'm not 100% sure where the RX clock delay is introduced, I will drop
> > mac3 entry in v4.
> 
> Many of the hyperscalers, or the supplies to the hyperscalers keep
> hitting this. The standard policy at the moment seems to be to drop
> Ethernet support. How useful is a BMC without Ethernet?
> 
> If you all got together and talked to aspeed, apply a bit of pressure,
> it should be possible to get this mess fixed pretty quickly. And then
> you could all have working Ethernet....

Hi Andrew,

I've already reached out to Ryan and Jacky from ASPEED regarding the
topic a few weeks ago. Originally I thought MAC-side clock delay was
only needed for fixed-linked (for example, in darwin dts), but looks
like it's also impacting platforms with PHY..

Anyways I will follow up with Jacky/Ryan after addressing all the
comments for this patch series.


Thanks,

Tao


Return-Path: <linux-aspeed+bounces-4507-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E657BC4451C
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jul 2026 04:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2DPF6kmcz3c6f;
	Sat, 18 Jul 2026 14:31:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784223022;
	cv=none; b=W2Lz0Qr/nFQ9HH17WxMtvuUyd9G+2CylKCXZPSzV1zgX7iIrreoXP2QzpLsZCQWUogfSloVIVFVtnAQc7fYNuuzCO63p1QWiI6hVGPuZmURBY3KVhNik+FhqvVBha99pIHeh4LLhNNa+rPSkV3kPSjKHPyrXcv1Ab2kymOp5frkzJHpiqz0Ei156joudISB9zbqQnr/EGbo2v+plVUtSw/F5LfQBiI3bx+Mk3XbeQjCiyMWTYRS81A0kZZabkv6u0rBesblGx0UkYX728S9Y0gRpcEwZTZOM/hga9iOX3CaBrPU1ghOyXziUIZS88TvrsZY7TbGo054j8ez1WEQm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784223022; c=relaxed/relaxed;
	bh=uCPldkKY5WQbG3wYqrfYXCPADMIMyTj8M/u2E2FHGl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T8QLWS8965uqUvjxOQ6FlVTyMYmTciiUNyMvOobvjxKvi6NK4UV5ui2jjSKlDsssY1CQfr7C2RK5IKp8A6qDhIso1gj9sGbN9ip+Ebj5XrjbToF1ARL1CdMMAxZ4ODULOheee2d2/dx8aZQFH7DrYHPQYUZxerDLdSCvX1jBdjEbMX6Goz39RrK7AjQCthmGA/37WZ8qejiYdDVGeZwjCdd8+v0orkI34EWO2i8isIQBjhYQ+5kTPIGxbB5VJ7WZzzDZAca73dbeVhbQvwFs//lU9gt3YKK+KUgFQOxYrDoJuLKM4xwQNPpAFZ0ALAiU4Id3lzTh0MLT0YTc3AWIHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMpeJLeR; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbZ2s33G; dkim-atps=neutral; spf=permerror (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMpeJLeR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbZ2s33G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1Kn93J4dz30Dq
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jul 2026 03:30:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784223015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCPldkKY5WQbG3wYqrfYXCPADMIMyTj8M/u2E2FHGl4=;
	b=SMpeJLeRDZhH+qHRPIZRhZiRZPgJDxY8oPn+0zz02eDKVJbNaBrQJADv/KwCrTl7IOLEdt
	6lQpsZh0Ci6mjko0wzebBD15jqcTQAYRBPPggi1UIJ+T/s/fRYD52PHVxwN4rorkTnNEOJ
	X/ey360zSRqGaUSA6Fk0L/rryCTBgwQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784223016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCPldkKY5WQbG3wYqrfYXCPADMIMyTj8M/u2E2FHGl4=;
	b=gbZ2s33GQM4pTpDoJnWsgiO6XWCVhJwdJRkJicJd/d/b3LNrFGrTR0z1zV2YW8tphIDFTu
	P/OLhhchhLpZ0Gd2JRD/bYcTJ5O4EhAH91J0FvW05sJWNS3HHiwH+vY06r0PIhgr1SlQsF
	Je7o9HdlmHJZWPaRS+dNDqshV4qwPAs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-d2Ll4cU5N-2m73jWDnBy_w-1; Thu, 16 Jul 2026 13:30:14 -0400
X-MC-Unique: d2Ll4cU5N-2m73jWDnBy_w-1
X-Mimecast-MFC-AGG-ID: d2Ll4cU5N-2m73jWDnBy_w_1784223013
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1e6f602cso66352501cf.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 10:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223013; x=1784827813;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCPldkKY5WQbG3wYqrfYXCPADMIMyTj8M/u2E2FHGl4=;
        b=KclbYDroeTEu569Z8YCCaHBMt1Suinrkx/qajzxpiRVhAnPPQCik+NJKk1n9bdvGaU
         9l+Q79LHUI/1TPVwj2vDFE5LSioh4Fh+sLVog3z8c0Dj8dxAgFGJDqEihYQ0xYrS50az
         PMi5rqluFEDofGCMhpFzegeUAgxWgGIrKu5Le6QCoyiU7ZHIxL0EA6CFNjm1FTehfUZB
         0Ob5evsSbR5io6Hq5c8nI8ZLV1ZeykI0IAmtP2aLfaJ/wTqumZKJ4x6nJyUf2e0ndKWe
         0uKOBdckCV3NXT2wALCFWV1gE81HKhhEe7kTUH8jas2MbWVF6j6hfO3n3HyqZ7wX4F3o
         r3aQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQuxj7827Qv+KQTvGqW3tTMYehkiYfoxcNp91EtPV0Hk+Yk4ZEW7hcZvHsTFWo7Y7e+1wjVFDXLBdJ46g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxfk9ZWaqqIgd/TmWNEchvPgTziICHX7FTbrhnVAaR+AKZLvfNv
	Xs+TnBAEl04z3X3LMX0h4SaEbGgrqRvZ6gwdgjQe+vlNFSLUmeeX34dLqV4GmrViNbvRkhCAyko
	u7pEhFLJr5rf98Q9zkOhrcezpluZ4zjaJPk8DrHvPbIj1jTyZqUP5AH2WETlAhpDkcAE=
X-Gm-Gg: AfdE7clPh+WAf9zc4HBJEY4BeAgYIiOpD1ys70h8sgzeJC5NFCrM3Db+BewAdk3w4ub
	zkb3Xt7qda6mn65SjoZFfPT55oQpjiA1gulYB7GHrY5T3M542p8ED/5QnzVobaPzWvmpxg+rQyH
	syLUS5Wf4W/Pn/KNLDOekHKAT0q817RhmB3YANOorCzFYWJQ1vuA+G/dfCcieuFPKlrPYZdH78d
	c7p34gbsLbE/4s3Gt08NSdwQpr05HlckYioyM5gHQ82zVmioYIkXEkWxmzd8J4LFoGHuiqYVczM
	DqJPfqgOBtbOgguxJiclh/lGatQSbeC19ivSIDyS5nNuvnXcJtA91bkdSG6hrp0w+axQaBql+/N
	aC0EqARYonS5eTyEQSzRMeFIjTMxSuzLuASo=
X-Received: by 2002:a05:622a:4018:b0:517:5bc1:e1f5 with SMTP id d75a77b69052e-520b9204263mr6434781cf.0.1784223013461;
        Thu, 16 Jul 2026 10:30:13 -0700 (PDT)
X-Received: by 2002:a05:622a:4018:b0:517:5bc1:e1f5 with SMTP id d75a77b69052e-520b9204263mr6434021cf.0.1784223012767;
        Thu, 16 Jul 2026 10:30:12 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caace31a4sm164561561cf.12.2026.07.16.10.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:30:11 -0700 (PDT)
Date: Thu, 16 Jul 2026 13:30:08 -0400
From: Brian Masney <bmasney@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: aspeed: ast2700: select AUXILIARY_BUS
Message-ID: <alkVIP8jfXuVFP5O@redhat.com>
References: <20260712160301.98941-1-kmehltretter@gmail.com>
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
In-Reply-To: <20260712160301.98941-1-kmehltretter@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dq8Grn6WydLrAeG8dvsHcJb1dvxvzTZ1Cn9Gjx6v8eY_1784223013
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 12, 2026 at 06:03:01PM +0200, Karl Mehltretter wrote:
> The AST2700 clock driver also exposes the SoC reset controller: it hands
> its register base to a reset auxiliary device via
> devm_auxiliary_device_create(), which the separate ASPEED reset driver
> (RESET_ASPEED) then binds to. That create call needs the auxiliary bus
> core (AUXILIARY_BUS), not the reset driver itself, but COMMON_CLK_AST2700
> does not select AUXILIARY_BUS.
> 
> It builds today only because RESET_ASPEED selects AUXILIARY_BUS and is
> normally enabled alongside the clock driver. On a randconfig with
> COMMON_CLK_AST2700=y and RESET_ASPEED=n, nothing pulls the auxiliary bus
> in and the kernel fails to link:
> 
>   ld: drivers/clk/aspeed/clk-ast2700.o: in function `ast2700_soc_clk_probe':
>   clk-ast2700.c:(.text+0x147c): undefined reference to `__devm_auxiliary_device_create'
> 
> Select AUXILIARY_BUS directly, as other clock drivers that create
> auxiliary devices do, so it builds regardless of the reset driver.
> 
> Fixes: fdc1eb624ddc ("clk: aspeed: add AST2700 clock driver")
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>



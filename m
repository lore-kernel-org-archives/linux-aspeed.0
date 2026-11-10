Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266D606A31C
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RlMcej0s
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNwmk3qXzz2xjN;
	Tue, 10 Nov 2026 16:53:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794289990;
	cv=none; b=OCrBhvfEijAv0H7HpNHo32f8FJ0NjpkjQtV4rV+5J51CZ5f24FbMyRnicZ35hFPmxAs+fWDjCQqupTUHU5OylsVlqeYd7SDAyVQ1FIrH7b8gfqiwivUeCQ4Ms6AEg3am1kfnTgRUy14FYdKWlaf75rSQRLoh8v1SKl03nJH2K+UNzkvAcHw1IEc7nfGsbE/AfSIVZ3LpW9FrYTc2wswJWIHWBJra4Y3svERabtMQ5eu6+CL7ntutwGUChHI2s96jkgs4n2que86V/AfOjVUO0bmtpgX8gHaURqfrVoN0XJE0rjkOqdl3sqvXAA4xWKt6WhuDLtSCqYCUQ96AlZEMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794289990; c=relaxed/relaxed;
	bh=YnyI1E/tXADZNI0XTbGcSGGT3VaZrgmrn187FtfBb6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3T7dyYBVZwhnAHR7Wx8FIJUzQwX+d6qlBOS4E1ZvC0VQB+SZ0AS4RD3fQ7aYTmCExLSKTNOqZcRDndghKLcOUC82B5+SGTyR043li8quzgWzAwhdQS4zxCNkS3ajaxqDcwkB3cbMgWqNraaW7JR5pDaPPDut8k4YSLvWh/HYLdarRejmfTaMMcBGD8LlWtCQoPttDjDQntlLdijrjrMBTTPNbo0+edSREHZttQbaWBLWpL7QugUzt/SXhcPuVGZJfHijtJCDOHaecr54FtkeAdB10YyXVx2OvsK7HWrsJ6b2FQpKU0+709xn0oPEGMXTnzIz5/nDP282GKi5AGSTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RlMcej0s; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RlMcej0s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNwmj2yvjz2xf8
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 16:53:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794289987;
	bh=YnyI1E/tXADZNI0XTbGcSGGT3VaZrgmrn187FtfBb6I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RlMcej0sH+YHRrPEV9YJUIDy+wr6QvgUvUSjUzl4ynFK/1A8o78bX9qhhf4hLaJBE
	 Cgvy6tJbLtFjESxgLDfQ5jUWGX9jCHJ7J99aQUIh2oDdIx9ZD40yjfvfqs584FmjMN
	 AO5kC+oLKBbDRMRfWNuLN3ER0TVOFagPaKoEAaNG7Gb6060YCs37/NL/sB6jvovceY
	 St82FWpxTZKZa9eOIBQWuhF5VmbeDPF+ycRnUkJaiyNVqvmK6DUak+/7QGwsJWCiFv
	 +WKdv8aHB3CcR/0EsGkGqEcxiX+udLc9ycwIKHIGblQlXb0O08pdPPuuWYBKBfM/rc
	 fIITpQN0q2Vlw==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C4AAC64C3C;
	Tue, 10 Nov 2026 13:53:05 +0800 (AWST)
Message-ID: <fff90721f7892c0285f4fed7fed460c7c1e183cb.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 2/3] ARM: dts: aspeed: Add Intel AVCRP BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Dawid Glazik <dawid.glazik@linux.intel.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maciej.lawniczak@intel.com, Andrew Lunn <andrew@lunn.ch>
Date: Tue, 10 Nov 2026 16:23:05 +1030
In-Reply-To: <ee6958ba4b93cde4719fbac89c4027964c2236bc.1794242015.git.dawid.glazik@linux.intel.com>
References: <cover.1794242015.git.dawid.glazik@linux.intel.com>
	 <ee6958ba4b93cde4719fbac89c4027964c2236bc.1794242015.git.dawid.glazik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-09 at 18:41 +0100, Dawid Glazik wrote:
> AVCRP is an Intel x86 server platform equipped with an ASPEED
> AST2600 BMC. The BMC is used for out-of-band management, platform
> monitoring, and system control.

It's probably my fault to some degree for not providing a better
explanation of what I was after on v4, and for merging changes from
others in the past that were pretty lax on the description, but what I
was hoping for was something more like e.g:

- f28674fab34f ("ARM: dts: aspeed: Add NVIDIA MSX4 HPM"), or
- bc83b7353d2b ("ARM: dts: aspeed: Add Facebook Anacapa platform")

Are there more details you can provide? If there are, I'm fine if you
reply here with them, and if there are no further concerns I can update
the commit message while applying the patches.

This also applies to the JNCRP patch that follows.

Andrew


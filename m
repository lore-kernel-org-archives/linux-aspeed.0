Return-Path: <linux-aspeed+bounces-3562-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA6AFD0068
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Mar 2026 13:41:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fP3BP5zG3z2yFK;
	Mon, 02 Mar 2026 00:41:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772372493;
	cv=none; b=fJK3sKimdj+UaTZPFdSl0Is4wxeEh88gqPl/kh/C35ndDPEHOXjCSaSoN1izD7aC/ma1+fHS/D3ex/hAJt8qW1HRnU/ZxpI6inV2l0R1/ueou27OZofLCS9goSfusd3UTJTdWFWkg6qQ0uyRstxlh9Ks+i89HVvpG0z13V6TNc8UphLsDtUurEwdFjphbS/O5SGmTJBs+XIZyaYMX2gZHjj7GLt+6+vbnHef/DNv27EvHr1afxF1PxQakDjKVNnd82mqPATbxNYTKJbDJk1KXaOVkt++NReJ+xNYZbr1KXwWq8pncynfLE2AsxkuqmaU/6Qsw370p4vqtno9ZIEygg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772372493; c=relaxed/relaxed;
	bh=IJR0gix/qcjxRB9opOK+DpKMd4C5hZuqEeiEi3zYUkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ii/SYsi3VaN97uG/TCPFZ7QFzjmNc7ByjfafFQwm1YZSosHEj65lSQvdXo8XvkpbJsk3HSNEfstHBGja3OZeJRn97xW/CjvAWSe6aJw1BYmEnwhiMFKBzjw2gNnx30v4Xo7as38UdQUa+7WgO/jZFtPH9Wgbh71f24Y595f8Gp8I6roySG1D04iGQhihWxJ8d0Ilm02Tx0Ou6myONCG6lcjMI6tq3JPTjql+uXT2VkgguyTA8GzSFo9Muvfn3K47yp3FrxEZu/vhKX+r+pt7OTk3twmkxPbR3UDEroIuFmuNwzASy9Dkx4O/QXGBYbPXJhxOJC6lHKeVl9op9u1Urw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FRjKGUAO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FRjKGUAO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fP3BP0WFRz2xqm
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Mar 2026 00:41:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2097F40A7A;
	Sun,  1 Mar 2026 13:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FB6C116C6;
	Sun,  1 Mar 2026 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772372490;
	bh=EpqZVzKWdEsIkiPzJLsZ2dOR2VUf0GLN3zoNLCZ07I0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FRjKGUAOwBXUw/Q4rIXTMJTFpyf/hELE745qa8J8eJbLJubMPF+dzDZ2/lHjLk7LC
	 4G4E9qEnfWW1NNbiShcur5+UphomtkhaTGlSeLbrjZtaQ+vG4PH4GXBYLMONfctJw2
	 V1fl1huk3bBdVGzaSf7H8dLFsuo2hojF20kKyu5VGD3Iu3l8TSWF8nTsByaEKcAa0g
	 L7xmfGmmgSKIVpIJj4ZX39j7yzS5dv3ttvEHg0fZsbFgkTGxcNOljeNz1yp52prbse
	 Rl6IlZ1x3C65VAtItkhlSsR3Rdx++DhswtBd+xb+sebjCLba53bJ/wZr6YSlkeo0aX
	 zr77y5F+pohQw==
Date: Sun, 1 Mar 2026 13:41:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: aspeed: clear reference voltage bits
 before configuring vref
Message-ID: <20260301134120.38ae5ae0@jic23-huawei>
In-Reply-To: <aQCXm_rvwpB6-UUq@smile.fi.intel.com>
References: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
	<aQCXm_rvwpB6-UUq@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 12:14:51 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Oct 28, 2025 at 01:41:02PM +0800, Billy Tsai wrote:
> > Ensures the reference voltage bits are cleared in the ADC engine
> > control register before configuring the voltage reference. This
> > avoids potential misconfigurations caused by residual bits.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---  
> 
> It's a v2 and here a changelog is missing.
> No need to resend, just reply with a missing piece.
> 

Billy. This one is still outstanding.

I was rather expecting a fixes tag as well.
I'm going to mark it as changes requested in patchwork and stop
tracking it. Hence please send a v3 addressing Andy's comment
and either add a fixes tag or say why one isn't appropriate.


Thanks,

Jonathan


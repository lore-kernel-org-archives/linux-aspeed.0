Return-Path: <linux-aspeed+bounces-1090-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B08C28B30
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 22:13:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJfwR3yJ2z30Bd;
	Fri, 21 Mar 2025 09:13:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742508791;
	cv=none; b=ZKNksPPGCLMnzIzCyIbrjwDC790EPkzuSgwaxxZzcnMABzqJMoEW109aZ/geAw/0Mwufvvc8HphyCYS7g6WDCYNaR0Bx9iCPGndqBX13FQeSFBgb2RieZGhJC+fRLnjzjcDcFEp3mtljCZeZhIsPdbWCUwSbFf/tNmi5xMy5bT9N6PPKa4JKB4ygc2BZO/86v3ds4pqfSwI+jXEjSWuCuVom08YOJ9x76zrmBOHoJrQ0beOW4wPR7J5BVq8ZxCP+MQoCByQy6ak/D22HvVJot58jQaFIrwc21Y+vM8YXCWdnad0iKUl73ilUoFlX0Pcdv7gGKDm/HJmb1i6A8RvOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742508791; c=relaxed/relaxed;
	bh=JMPcFOn4UwYXter5dbI+9cINmWX56V1KwEkN69pNmGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jdb6cpomTqqquPAxMjooGZ5O/V0h06qobDyjDS8CeWXSTSpKpLZUJzvR0acMeSmqP4+Sl6JqU/LShJ7TEfQT+L7bVsSHk4GLjI93DwHTpNOvMvQX9DJ/TdN1z1cmxLyH/F2F3+QL8bmmls2YSAm6MdKsIQwJ00OuN1o/nOEtqGvueIhmXHa4S7VSNS5CQMzZxNwJMH/8xizdLVFqp1m/RKfDKm2emWoX+OPhSMQyvzt3YcssnX3PRv0jcT8DncbpQ+/zhXzE5WNnFAwOIRr178qKzBjsqtRpjNfmwDkF2K6M8QnNX5p3haKS+jnB2LpCEU6ZSWbXQDx0fVaKhoStyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IUOSq3fe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IUOSq3fe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJfwQ6X5kz309v
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 09:13:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E00FF6159E;
	Thu, 20 Mar 2025 22:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B68C4CEDD;
	Thu, 20 Mar 2025 22:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742508787;
	bh=M7qrseV6fB8Hed0ymLja/KLmZm6erUG8Gh3U6YrkLzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUOSq3feRUEOLLgSW7vUdrZ3wJPw87ZS4Toe3mUkTuhPH5XGp5YVvt9gMvIKPX1kf
	 YB7nJQHtbQ5nu9G55CeNT0kxzrAPHXQc6s5EhvFJ1gz2Kkh1uUBY/OTAN2uMsOj8/D
	 idKvcye6uePTP1C5zBx7UOvTb7aTTKcUFX0H+2gb9MvfDN0ybup9S0jlbU1OwxxALL
	 QxHt8OlRrBIWUsskCpfVvS/58obwwGLzRf5ks1sVtktni2nzjB/oOZg0xuKogerK2w
	 bbBC6i+/gQDKT154qksc8V0s86kNMrgFIUxyzzt94+lXxqcL5qzaaya7EV/tYeUcQn
	 3ufYvYPor93WQ==
Date: Thu, 20 Mar 2025 23:13:03 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, 
	Rob Herring <robh+dt@kernel.org>, Rayn Chen <rayn_chen@aspeedtech.com>, 
	Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai@quantatw.com>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] aspeed: i2c: add clock duty cycle property
Message-ID: <jcznjekoig6n5jtispbgxn6ingzteodwb5lib77evsvvufldoh@ia57mjlvie5k>
References: <20220610054722.32229-1-potin.lai.pt@gmail.com>
 <20220610054722.32229-2-potin.lai.pt@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610054722.32229-2-potin.lai.pt@gmail.com>

Hi Potin,

On Fri, Jun 10, 2022 at 01:47:21PM +0800, Potin Lai wrote:
> Introduce i2c-clk-high-min-percent property for setting a minimum clock
> high percentage.
> 
> This driver calculate clk_high and clk_low with giving duty cycle. If it
> could not find a suit clk_high and clk_low, it apply default duty cycle
> 50%.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

if you have still interest in getting this patch applied, may I
ask you to please resubmit it?

Thanks,
Andi


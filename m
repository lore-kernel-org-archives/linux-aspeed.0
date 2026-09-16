Return-Path: <linux-aspeed+bounces-5016-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5904CC88E5C
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 10:32:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlFZx4qYlz2y2W;
	Wed, 16 Sep 2026 20:32:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789554777;
	cv=none; b=bq55qRR1BOq+KsfmTg6zNMN2J7BXhDWFs5tp2rNfcSyVedy8z0jnBOR8vjUoMtmMTC5Yjm1YMr3wOurVHGDUhPb9MIiP3Gdgf+6AIbmsa9yRgPnTYcnuh5O5HHxQ2YRA0OEtwlxta7BOdzovYIulJu7xDuUEpXuEXAFiuQURtcHPkOjFzcs5TitriZgdjdnj1s6g/Ch2SVHbBHR+4KQDBNsiuyUorNw2svdsk5FFvygULd83fD5mw2SmMl7vfAk9FkS5ekEqUW10zDoVMETGSpmFF/kV6wJjzSBb6+3D6fL/ebpH4Es/6NoFzqdW192F8rDUxfvsbBTC1Afj1hDzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789554777; c=relaxed/relaxed;
	bh=08PC1Zy0osrxD5uEEq52omja9Cyu6/fzLf/OJPTukEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMy9Lxo2h54e6BFzGCXOeSZRRT+AKKvTiEth6sRUTZS8SOdKbp/nGFYo/09vmZh6gHYfGy6DmfP4g/PJ9s1cRO5oqIoOyyEohdnTMeIalLsbrZK+wXHS3Okk/sL1Vu3jg3wfsnZfs0VcWJCRTUcZtpMJAc5Qd47940vhXam5YwFJgU4j59UxOAOcHT9pDTOg9hzaCMHU8bu5oX4dn8586lniFtrfLYudN/sPoKA4nPTeoLe25HyARhTJTM8oxV2iklmuBTuT/3IsuPU5QpAMiUQPE83zp+pTtkaipa14QPHj75S95LFDMmXw/fzWF80paivQqQKW/GT4BMk3YQSeTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tbywcfMn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tbywcfMn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlFZw0jVDz2xqp;
	Wed, 16 Sep 2026 20:32:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C5E31401F8;
	Wed, 16 Sep 2026 10:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268951F00898;
	Wed, 16 Sep 2026 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789554771;
	bh=08PC1Zy0osrxD5uEEq52omja9Cyu6/fzLf/OJPTukEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tbywcfMnjR9YbGgjGoowoWtoypFwkV04/m0T075x2cdlw9JNqAq64HWPaf0Ohm/MZ
	 luOknS14HacrIaIWw5qRZgHVabt0VQBt+nhPjnhMa3JT15e5lbIKna3i7eHjypHE9p
	 3oCBhYdbi4A7ucwJ2UOq7epdMiLyPmYfllsvdQyk=
Date: Wed, 16 Sep 2026 10:44:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alistair@popple.id.au, andrew@codeconstruct.com.au,
	eajames@linux.ibm.com, joel@jms.id.au,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	ninad@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] fsi: master-aspeed: Fix of_node reference leak in
 fsi_master_aspeed_probe()
Message-ID: <2026091644-equipment-landlady-c1c0@gregkh>
References: <20260916093914.2005582-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20260916093914.2005582-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 09:39:14AM +0000, Wentao Liang wrote:
> In fsi_master_aspeed_probe(), a reference to the device tree node is
> taken with of_node_get() and stored in master.dev.of_node.  If
> fsi_master_register() fails, the error path frees the master without
> putting that reference, leaking it.
> 
> Put the device node reference before returning on the error path.
> of_node_put() tolerates a NULL node, so the earlier err_release path
> via opb_readl() is unaffected.
> 
> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/fsi/fsi-master-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index aa1380cdff33..7c7f30c2b8e6 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -640,6 +640,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_release:
> +	of_node_put(aspeed->master.dev.of_node);
>  	clk_disable_unprepare(aspeed->clk);
>  err_free_aspeed:
>  	kfree(aspeed);
> -- 
> 2.34.1
> 
> 

did you forget an Assisted-by: tag?


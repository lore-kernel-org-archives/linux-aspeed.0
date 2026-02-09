Return-Path: <linux-aspeed+bounces-3507-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F51EF06FF
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 06:52:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8b41194gz2yFm;
	Mon, 09 Feb 2026 17:52:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770619969;
	cv=none; b=Ued5bzXHD6oVEv7UAUFcbYqEJhAB1Nsd0nFhxD+cF1yseHHc0dLTKVq17ohKl+3fRjCIDZzOZTY5Iy9coeKAcc+P04SSL+26dpD7BoM4iU8ovUX2h+D5YRnB04eYBbGhqvo3xb0rnF9n62hdcGRKgELhr3P02s4f1I6m9/039mwTCZWRGdx8Chyd7pYW+whRQ6rgPKfGGlwBPEuUTwTj59gwBeiaDQiujMe6HuzbI9Z5wz/d8lLOqruOWZDTSlNF5nOXOjH7XC7eEUw2i3y7s7cGEEWzkMoJhFfvAian74EDF2GpkZDebJ9IGQtv3LtzU9w44uBbHY/MDkZYam8Ceg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770619969; c=relaxed/relaxed;
	bh=DXnA0j3/Uan5NIBQI4I1W6jnHOtSk+oiYxhKLyk1rQs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHDgQZCPVbrN8xwCVpyBLpM33Kpfiyl1FNwy8+zG1bVj7AX5N4ZPLfq5H7mx0ZQz+ui18VA2ldqqPkQVC7Vfc+wVFaRgQwmg+U/3f+uq5hrHf/FDM6I5hTnwUnSOKCFVDjC7lrXar3S89HFwpogItcej5FloToasd+HUCfJEHZazfRrWcofPadtYVS6NyZkj9Gk7HiX/2UpgiuEZ3wRMDBlHhTD6ischCqB8cRouCw/i1MgelcuxcArqALfPOD09S7gnMysykbT5+4FnHY9Co1YYlXbTJcOBwQTSik5JXbNZOt3kaA8yoCVICjNdG4+dPCYAlHpifyU4nshBKkBaVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZczRkzXw; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZczRkzXw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8b404DnTz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 17:52:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770619967;
	bh=DXnA0j3/Uan5NIBQI4I1W6jnHOtSk+oiYxhKLyk1rQs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZczRkzXwsZb8Vw/Es5bl+YtLjtKWM8ggFl4VnyzivSXkJxsukfBKPb8BKjxgEaSw6
	 W36H3pIY8DaDHOJcdoyF6GV6x/BgedWJJpWgZvXxpXL8WtJDlOSxCCYfd2FvwAWJgb
	 FqU75z1xX1v/DSFsD2qONMNHJH/T63ZXMuOxNJUBhoNlLrO07QT77yZec17HF4tBa7
	 ZTymBHYvEGEJiP3uGTYtbRGzlo9TQUnKhunR6bBH9a1AM2bBigMlp9on8u/kfJOgm9
	 aWuB41PCIGSne8cqrcD0xTGrsZsys4L8ZHW5l7HvvYTFIrgW2F9WZaFklDEAfYXZO+
	 ZV95GtEoFbRgw==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5679B602DE;
	Mon,  9 Feb 2026 14:52:47 +0800 (AWST)
Message-ID: <e7671063304f1bfdb66bc4e7d271c9e836bbe3cc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add Meta SanMiguel BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, Potin Lai
	 <potin.lai@quantatw.com>, Roger Kan <Roger.Kan@quantatw.com>
Date: Mon, 09 Feb 2026 17:22:47 +1030
In-Reply-To: <20260203-sanmiguel_init_dts-v2-2-6a5682c32b38@gmail.com>
References: <20260203-sanmiguel_init_dts-v2-0-6a5682c32b38@gmail.com>
	 <20260203-sanmiguel_init_dts-v2-2-6a5682c32b38@gmail.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-02-03 at 17:48 +0800, Potin Lai wrote:
> Add linux device tree entry for Meta (Facebook) SanMiguel compute-
> tray
> BMC using AT2620 SoC.
>=20
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

Ah, I missed that there was a v2, however my comments on the v1 DTS
still appear to apply. Can you address them?

Andrew


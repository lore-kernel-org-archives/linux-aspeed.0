Return-Path: <linux-aspeed+bounces-1635-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C00C83F0B
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 14:48:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYc2d19Nqz30WS;
	Sat,  5 Jul 2025 00:48:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751640521;
	cv=none; b=ZNWau6/4/UlEI7AJ3vKhPNb67FdlhqrHotM4cf6UgSnt7vdoKms+ZSedX6WyM0sKJsh8lmsnRt2PR1ZuXRxDws3x/cZ57obQ02xRwr/tiJ+Gv+qxh2ETHFFwFJGpnQOBCCXkvHF/WOWS7T2V82ei3DrMY6WSSZJub19AoVEXRt4p2/FAcARRC/nl8SwsMiYSvRqQ24NKW9oXNlwEngyTofX/tmucqLa9U3JXIsZqx38PwqyVV/IElccPoFJT7kislwi4wqtCrMA1lM35m5QtzYcFs1q3X5V1CSokYnIHpVEZ79zhCH1imePHjhE5tNeYUGrCs5XIEjiaOLhAkwSi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751640521; c=relaxed/relaxed;
	bh=jDuinaPR64zVqK1kEHxNBJvXQ3xp9ELmQCqfHweGrhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBPISNQ9Z51LbpiofKmqRXI5F4sN7OHQ3q31lJqyzXNTvG20i3NU5eZj2s5wT2icTN08J9XJM5Et//DaDiN4mWqTCO6VuDiq4MfZ31Fl7OEB5tnbSj22ft6cwD0aGop+V8MWE1by3nMSTkix+I7ou01fQ/PCRNi67lmfkZ/YECHek7T0G7PUu1eI2GbOlqy17v70gZsPd9Kp2ZYwRmhYngarvrez2dHSOIPRju51LHgjV8SZ1sMlDyHnhi+gHyUX1OUPj0Evb1eGBnBOdlk4fKlKsLhfDwz0QeuXeVDfyOjIit2wYazKVCAaOA5pt6s+/jZtiDfiQTLDGooA/yy9Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JI5jseJB; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fsbL5TB5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yi8oHM7s; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oRK85OcJ; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jdelvare@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JI5jseJB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fsbL5TB5;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yi8oHM7s;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oRK85OcJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jdelvare@suse.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 334 seconds by postgrey-1.37 at boromir; Sat, 05 Jul 2025 00:48:39 AEST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYc2b5sLVz30Vr
	for <linux-aspeed@lists.ozlabs.org>; Sat,  5 Jul 2025 00:48:39 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63573211BA;
	Fri,  4 Jul 2025 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751640176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDuinaPR64zVqK1kEHxNBJvXQ3xp9ELmQCqfHweGrhI=;
	b=JI5jseJB7B/YhYbzYvXeagZZyF9c2hIdxNnfDIAW81eDpL5Fh/FbdYyV1HQLlHupvjMZEm
	TuNDP87VhVyizcXbU82dRdXBdfedgny0GvnBrpKzvM02uoCb1kZKVPvi2Igyi+1YFM8Oyt
	nHob6ZxJv7v3u3FsZYTE7jB3A+HpMd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751640176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDuinaPR64zVqK1kEHxNBJvXQ3xp9ELmQCqfHweGrhI=;
	b=fsbL5TB5hLciuclaRNawX3H/a+4dnOFecIz/fIv8nHU9mXV28LDI85ld/cM29kx1wKMnVv
	l8W6RlSuxeUVdtDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751640175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDuinaPR64zVqK1kEHxNBJvXQ3xp9ELmQCqfHweGrhI=;
	b=Yi8oHM7sUV41hh65wylwSGn80poGIh+0wbgJiLwo71CYjFFYLS5dUczUKrxY23tcrK/Ko4
	XwR2rgINKNPiMQTrv5HPF2NrW20PN+GUhg1Ta03GzTPjS70waIhZxC/i6NOUD63i4KUFXa
	c0uvuPiVLMIfR1nUgsuX++dRDybcnpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751640175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDuinaPR64zVqK1kEHxNBJvXQ3xp9ELmQCqfHweGrhI=;
	b=oRK85OcJA+qB91kIW95y3wnR5u/gfiEy7ES/IzngxEcncAypzncFteNHuzXF0dPNZ6dLoT
	v3HaT6ILvYDYKwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1BA613A71;
	Fri,  4 Jul 2025 14:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CgyCNG7oZ2hIfAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 04 Jul 2025 14:42:54 +0000
Date: Fri, 4 Jul 2025 16:42:39 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>,
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] soc: aspeed: lpc-snoop: Switch to
 devm_clk_get_enabled()
Message-ID: <20250704164239.2f3a7d62@endymion>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-7-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	<20250616-aspeed-lpc-snoop-fixes-v2-7-3cdd59c934d3@codeconstruct.com.au>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
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
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,yahoo.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,jms.id.au,gmail.com,9elements.com,yahoo.com,linux.ibm.com,google.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,codeconstruct.com.au:email,suse.de:email]

Hello Andrew,

On Mon, 16 Jun 2025 22:43:44 +0930, Andrew Jeffery wrote:
> Simplify clock handling as done in other drivers.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> (...)

LGTM.

Acked-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support


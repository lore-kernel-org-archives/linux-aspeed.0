From: Larry Finger <Larry.Finger@lwfinger.net>
Date: Mon, 22 Nov 2021 12:38:41 -0600
Subject: [PATCH/RFC 17/17] rtw89: Use bitfield helpers
In-Reply-To: <f7b81122f7596fa004188bfae68f25a68c2d2392.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <f7b81122f7596fa004188bfae68f25a68c2d2392.1637592133.git.geert+renesas@glider.be>
Message-ID: <a18f44bf-e590-0ebe-00c0-5658f3a51d86@lwfinger.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/22/21 09:54, Geert Uytterhoeven wrote:
> Use the field_{get,prep}() helpers, instead of open-coding the same
> operations.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> Marked RFC, as this depends on [PATCH 01/17], but follows a different
> path to upstream.
> ---
>   drivers/net/wireless/realtek/rtw89/core.h | 38 ++++-------------------
>   1 file changed, 6 insertions(+), 32 deletions(-)

Tested-by: Larry Finger <Larry,Finger@lwfinger.net>

Larry

> 
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
> index c2885e4dd882f045..f9c0300ec373aaf2 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -2994,81 +2994,55 @@ rtw89_write32_clr(struct rtw89_dev *rtwdev, u32 addr, u32 bit)
>   static inline u32
>   rtw89_read32_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
>   {
> -	u32 shift = __ffs(mask);
> -	u32 orig;
> -	u32 ret;
> -
> -	orig = rtw89_read32(rtwdev, addr);
> -	ret = (orig & mask) >> shift;
> -
> -	return ret;
> +	return field_get(mask, rtw89_read32(rtwdev, addr));
>   }
>   
>   static inline u16
>   rtw89_read16_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
>   {
> -	u32 shift = __ffs(mask);
> -	u32 orig;
> -	u32 ret;
> -
> -	orig = rtw89_read16(rtwdev, addr);
> -	ret = (orig & mask) >> shift;
> -
> -	return ret;
> +	return field_get(mask, rtw89_read16(rtwdev, addr));
>   }
>   
>   static inline u8
>   rtw89_read8_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
>   {
> -	u32 shift = __ffs(mask);
> -	u32 orig;
> -	u32 ret;
> -
> -	orig = rtw89_read8(rtwdev, addr);
> -	ret = (orig & mask) >> shift;
> -
> -	return ret;
> +	return field_get(mask, rtw89_read8(rtwdev, addr));
>   }
>   
>   static inline void
>   rtw89_write32_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u32 data)
>   {
> -	u32 shift = __ffs(mask);
>   	u32 orig;
>   	u32 set;
>   
>   	WARN(addr & 0x3, "should be 4-byte aligned, addr = 0x%08x\n", addr);
>   
>   	orig = rtw89_read32(rtwdev, addr);
> -	set = (orig & ~mask) | ((data << shift) & mask);
> +	set = (orig & ~mask) | field_prep(mask, data);
>   	rtw89_write32(rtwdev, addr, set);
>   }
>   
>   static inline void
>   rtw89_write16_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u16 data)
>   {
> -	u32 shift;
>   	u16 orig, set;
>   
>   	mask &= 0xffff;
> -	shift = __ffs(mask);
>   
>   	orig = rtw89_read16(rtwdev, addr);
> -	set = (orig & ~mask) | ((data << shift) & mask);
> +	set = (orig & ~mask) | field_prep(mask, data);
>   	rtw89_write16(rtwdev, addr, set);
>   }
>   
>   static inline void
>   rtw89_write8_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u8 data)
>   {
> -	u32 shift;
>   	u8 orig, set;
>   
>   	mask &= 0xff;
> -	shift = __ffs(mask);
>   
>   	orig = rtw89_read8(rtwdev, addr);
> -	set = (orig & ~mask) | ((data << shift) & mask);
> +	set = (orig & ~mask) | field_prep(mask, data);
>   	rtw89_write8(rtwdev, addr, set);
>   }
>   
> 


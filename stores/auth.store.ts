interface IAuthStore {
  id: string
  email: string
  username: string
  level: number
  role: string
  status: boolean
}

const defaultValue: {user: IAuthStore} = {
  user: {
    id: '',
    email: '',
    username: '',
    level: 1,
    role: 'guest',
    status: false,
  },
}

export const useAuthStore = defineStore('auth', {
  state: () => defaultValue,
  getters: {
    isAuth: state => state.user.status
  },
  actions: {
    clear(){
      this.$patch(defaultValue)
    },
    set(input: IAuthStore){
      this.$patch({user: input})
    }
  }
})

export const useIsLoadingStore = defineStore('isLoading', {
  state: () => ({
    isLoading: true,
  }),
  actions: {
    set(data: boolean){
      this.$patch({isLoading: data})
    }
  }
})